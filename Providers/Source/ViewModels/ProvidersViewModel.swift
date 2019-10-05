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
    
    
    
    // MARK: - Public methods
    
    func getProviders() {
        guard let json = getJsonFromResources() else { return }
        guard let providersStructure = try? JSONDecoder().decode(ProvidersStructure.self, from: json) else { return }
            
        providers = providersStructure.providers
        setCardSettings()
        print(providers)
        providers.forEach {print( $0.giftCards)}
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
        guard let path = Bundle.main.path(forResource: "bigdata", ofType: "json") else { return nil }
        
        do { return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) }
        catch { fatalError("File providers.json was not found in \(path).") }
    }
    
    /// Установить дополнительные настройки для карты
    private func setCardSettings() {
        for provider in providers {
            for card in provider.giftCards {
                downloadImage(for: card)
                card.provider = provider
            }
        }
    }
    
    /// Загрузить логотипы провайдеров в карточках
    private func downloadImage(for card: Card) {
        guard let url = URL(string: card.imageURL) else { return }
        do {
            card.imageData = try Data(contentsOf: url)
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
}
