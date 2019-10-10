//
//  ProvidersViewModel.swift
//  Providers
//
//  Created by Victor Volnukhin on 03/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import RxSwift
import RxCocoa

class ProvidersViewModel: ProvidersViewModelProtocol {
    
    
    // MARK: - Public properties
    
    var providers = BehaviorRelay(value: [Provider]())
    
    var providersCount: Int {
        return providers.value.count
    }
    
    
    // MARK: - Reactive properties
    
    var disposeBag = DisposeBag()
    
    
    // MARK: - Resouces properties
    
    lazy var resourceService: ResourceServiceProtocol = chooseNeededResourceService()
    
    
    // MARK: - Public methods
    
    func getProviders() {
        // Можно выбрать загрузку данных из файла, указав в info.plist свойство "Load Data from File" как YES.
        // Если это свойство "NO", то будет загружаться с сервера по указанной ссылке в свойстве "Providers Data URL".
        resourceService.loadDataFromResource(url: AppConstant.api.path) { [weak self] data in
            guard let json = data else { return }
            guard let providersStructure = try? JSONDecoder().decode(ProvidersStructure.self, from: json) else { return }
            self?.providers.accept(providersStructure.providers)
        }
    }
    
    func getProvider(with index: Int) -> Provider {
        return providers.value[index]
    }
    
    func getProvider(by id: Int) -> Provider? {
        return providers.value.first(where: { $0.id == id })
    }
    
    func getCard(by index: Int, and providerID: Int) -> Card? {
        guard let provider = getProvider(by: providerID) else { return nil }
        return provider.giftCards[index]
    }
    
    func getCardCount(by providerID: Int) -> Int {
        guard let provider = getProvider(by: providerID) else { return 0 }
        return provider.giftCards.count
    }
    
    
    
    // MARK: - Private methods
    
    /// Функция выбора конкретного варианта загрзчика данных из ресурсов
    private func chooseNeededResourceService() -> ResourceServiceProtocol {
        // Для использования файлов в папке приложения Assets, выберете класс AssetsResourcesService.
        // Для скачивания файлов с сервера - класс AlamofireResourceService.
        return AppConstant.config.isLoadDataFromFile ? AssetsResourceService() : AlamofireResourceService()
    }
    
}


extension ProvidersViewModel: CachableImageDownloaderProtocol {

    func downloadImage(url: String, completionHandler: @escaping (Data?) -> Void) {
        // Проверка: загружалась ли картинка по указанному урл ранее?
        if let cacheImage = Cache.instance[url] {
            completionHandler(cacheImage)
            return
        }
        
        // Проверка: валидный ли урл был передан
        guard let url = URL(string: url) else {
            completionHandler(nil)
            return
        }
        
        // Реактивный запрос на сервер
        URLSession.shared.rx
            .response(request: URLRequest(url: url))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { response, data in
                switch response.statusCode {
                case 200:
                    Cache.instance[url.absoluteString] = data
                    completionHandler(data)
                default:
                    completionHandler(nil)
                }
            })
            .disposed(by: disposeBag)
    }
    
}
