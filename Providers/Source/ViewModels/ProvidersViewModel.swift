//
//  ProvidersViewModel.swift
//  Providers
//
//  Created by Victor Volnukhin on 03/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import Foundation

class ProvidersViewModel: ProvidersViewModelProtocol {
    
    
    // MARK: - Public properties
    
    var providers = [Provider]()
    
    var providersCount: Int {
        return providers.count
    }
    
    
    // MARK: - Public methods
    
    func getProviders() {
        guard let json = getJsonFromResources() else { return }
        guard let providersStructure = try? JSONDecoder().decode(ProvidersStructure.self, from: json) else { return }
            
        providers = providersStructure.providers
        print(providers)
    }
    
    func getProvider(with index: Int) -> Provider {
        return providers[index]
    }
    
    func getCardsCount(in section: Int) -> Int {
        let neededProvider = providers[section]
        return neededProvider.giftCards.count
    }
    
    func getCard(in section: Int, with index: Int) -> Card {
        let neededProvider = providers[section]
        return neededProvider.giftCards[index]
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
