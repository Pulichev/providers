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

    
    // MARK: - Network properties
    
    /// Сервис обменивающийся информацией с сервером
    var networkService: NetworkServiceProtocol = AlamofireNetworkService()
    
    
    
    // MARK: - Public methods
    
    func getProviders() {
        guard let json = getJsonFromResources() else { return }
        guard let providersStructure = try? JSONDecoder().decode(ProvidersStructure.self, from: json) else { return }
            
        providers.accept(providersStructure.providers)
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
    
    /// Чтобы "обкатать" выполнение, было решено добавить JSON в файл.
    /// Эта функция позволит получить этот файл и продолжить с ним работу.
    private func getJsonFromResources() -> Data? {
        guard let path = Bundle.main.path(forResource: "providers", ofType: "json") else { return nil }
        
        do { return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) }
        catch { fatalError("File providers.json was not found in \(path).") }
    }
    
}


extension ProvidersViewModel: ImageDownloaderProtocol {

    func downloadImage(url: String, completionHandler: @escaping (Data?) -> Void) {
        guard let url = URL(string: url) else {
            completionHandler(nil)
            return
        }
        URLSession.shared.rx
            .response(request: URLRequest(url: url))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { response, data in
                switch response.statusCode {
                case 200:
                    completionHandler(data)
                default:
                    completionHandler(nil)
                }
            })
            .disposed(by: disposeBag)
    }
    
}
