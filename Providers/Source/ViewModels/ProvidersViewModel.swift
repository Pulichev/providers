//
//  ProvidersViewModel.swift
//  Providers
//
//  Created by Victor Volnukhin on 03/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import RxSwift

class ProvidersViewModel: ProvidersViewModelProtocol {
    
    
    // MARK: - Public properties
    
    var providers = [Provider]()
    
    var providersCount: Int {
        return providers.count
    }

    
    // MARK: - Network properties
    
    /// Сервис обменивающийся информацией с сервером
    var networkService: NetworkServiceProtocol = AlamofireNetworkService()
    
    
    // MARK: - Reactive properties
    
    /// Данные по картинке с логотипом провайдера
    var imageData = PublishSubject<Data>()

    /// Параметр, информирующий об ошибке от сервера
    var error = PublishSubject<String>()
    
    
    
    // MARK: - Public methods
    
    func getProviders() {
        guard let json = getJsonFromResources() else { return }
        guard let providersStructure = try? JSONDecoder().decode(ProvidersStructure.self, from: json) else { return }
            
        providers = providersStructure.providers
    }
    
    func getProvider(with index: Int) -> Provider {
        return providers[index]
    }
    
    func getProvider(by id: Int) -> Provider? {
        return providers.first(where: { $0.id == id })
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
    
    
    // MARK: - Private properties
    
    private var serverErrorDescription: String {
        return "Application could not received data from server."
    }
    
    
    // MARK: - Public methods
    
    func downloadImage(for model: ImageableModelProtocol) {
        guard let url = URL(string: model.imageURL) else { return }
        
        networkService.sendRequest(url: url) { [weak self] (data, error) in
            if let error = error {
                self?.serverErrorHandler(error: error)
                return
            }
            
            if let data = data {
                self?.serverResponseHandler(data: data)
            }
        }
    }
    
    
    // MARK: - Server Response Handler
    
    private func serverResponseHandler(data: Data) {
        // Сообщаем всем подписчикам, что получили новую картинку
        imageData.onNext(data)
    }
    
    private func serverErrorHandler(error: Error) {
        // Сообщаем всем подписчикам, что получили ошибку от сервера
        self.error.onNext(serverErrorDescription)
        self.error.onCompleted()
        print(error.localizedDescription)
    }
}
