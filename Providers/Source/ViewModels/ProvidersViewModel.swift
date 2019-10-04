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
    
    var cardsCount: Int {
        guard let provider = currentProvider else { return 0 }
        return provider.giftCards.count
    }
    
    /// Провайдер, с которым недавно работали
    var currentProvider: Provider?
    
    /// Карта провайдера, с которой недавно работали
    var currentCard: Card?
    
    
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
        downloadCardImages()
        print(providers)
    }
    
    func getProvider(with index: Int) -> Provider {
        let neededProvider = providers[index]
        currentProvider = neededProvider
        return neededProvider
    }
    
    func getCard(with index: Int) -> Card? {
        guard let provider = currentProvider else { return nil }
        let neededCard = provider.giftCards[index]
        currentCard = neededCard
        return neededCard
    }
    
    
    
    // MARK: - Private methods
    
    /// Чтобы "обкатать" выполнение, было решено добавить JSON в файл.
    /// Эта функция позволит получить этот файл и продолжить с ним работу.
    private func getJsonFromResources() -> Data? {
        guard let path = Bundle.main.path(forResource: "providers", ofType: "json") else { return nil }
        
        do { return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) }
        catch { fatalError("File providers.json was not found in \(path).") }
    }
    
    /// Загрузить логотипы провайдеров в карточках
    private func downloadCardImages() {
        for provider in providers {
            for var card in provider.giftCards {
                guard let url = URL(string: card.imageURL) else { return }
                do {
                    card.imageData = try Data(contentsOf: url)
                    print("New image data for \(card.id)")
                }
                catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        
        
//        providers.forEach {
//            $0.giftCards.forEach {
//                guard let url = URL(string: $0.imageURL) else { return }
//                $0.imageData = Data(contentsOf: url)
//            }
//        }
    }
    
}

extension ProvidersViewModel: ImageDownloaderProtocol {
    
    
    // MARK: - Private properties
    
    private var serverErrorDescription: String {
        return "Application could not received data from server."
    }
    
    
    // MARK: - Public methods
    
    func downloadImage(completionHandler: @escaping (Data) -> (Data)) {
        guard let card = currentCard else { return }
        guard let url = URL(string: card.imageURL) else { return }
        
        networkService.sendRequest(url: url) { [weak self] (data, error) in
            if let error = error {
                self?.serverErrorHandler(error: error)
                return
            }
            
            if let data = data {
                completionHandler(data)
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
        print(error.localizedDescription)
    }
}
