//
//  ProvidersViewModelProtocol.swift
//  Providers
//
//  Created by Victor Volnukhin on 03/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import Foundation

protocol ProvidersViewModelProtocol {
    
    
    // MARK: - Properties
    
    var providers: [Provider] { get set }
    
    /// Количество найденных провайдеров
    var providersCount: Int { get }
    
    /// Количество найденных у провайдера карт
    var cardsCount: Int { get }
    
    
    
    // MARK: - Functions
    
    /// Запросить всех провайдеров с сервера
    func getProviders()
    
    /// Возращает требующегося провайдера по индексу
    func getProvider(with index: Int) -> Provider
    
    /// Возвращает карту провайдера по индексу провайдера
    func getCard(with index: Int) -> Card?
    
}
