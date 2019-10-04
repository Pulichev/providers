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
            for card in provider.giftCards {
                guard let url = URL(string: card.imageURL) else { return }
                do {
                    card.imageData = try Data(contentsOf: url)
                }
                catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
