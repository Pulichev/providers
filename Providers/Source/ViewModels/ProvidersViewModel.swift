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
    
    // Для использования файлов в папке приложения Assets, выберете класс AssetsResourcesService.
    // Для скачивания файлов с сервера - класс AlamofireResourceService.
    //var resourceService: ResourceServiceProtocol = AssetsResourceService()
    var resourceService: ResourceServiceProtocol = AlamofireResourceService()
    
    
    // MARK: - Public methods
    
    func getProviders() {
        // Для сервиса AssetsResouceService:
        // guard let url = AppConstant.urls.providersJson else { return }
        // Для сервиса AlamofireResouceService:
        let url = AppConstant.api.path
        resourceService.loadDataFromResource(url: url) { [weak self] data in
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
