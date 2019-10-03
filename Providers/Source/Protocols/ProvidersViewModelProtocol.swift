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
    
    
    // MARK: - Functions
    
    /// Запросить всех провайдеров с сервера
    func getProviders()
    
    /// Возращает требующегося провайдера по индексу
    func getProvider(with index: Int) -> Provider
    
    /// Возвращает количество карт провайдера по индексу провайдера
    func getCardsCount(in section: Int) -> Int
    
    /// Возвращает карту провайдера по индексу провайдера
    func getCard(in section: Int, with index: Int) -> Card
    
}
