//
//  ProvidersViewModelProtocol.swift
//  Providers
//
//  Created by Victor Volnukhin on 08/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import RxSwift
import RxCocoa

protocol ProvidersViewModelProtocol {
    
    
    // MARK: - Providers properties
    
    var providers: BehaviorRelay<[Provider]> { get set }
    
    /// Количество найденных провайдеров
    var providersCount: Int { get }
    
    
    // MARK: - Services
    
    var resourceService: ResourceServiceProtocol { get set }
    
    var networkService: NetworkServiceProtocol { get set }
    
    var errorOfService: PublishSubject<String> { get set }
    
    
    
    // MARK: - Initializers
    
    init(resourceService: ResourceServiceProtocol, networkService: NetworkServiceProtocol)
    
    
    
    // MARK: - Functions
    
    /// Запросить всех провайдеров с сервера
    func getProviders()
    
    /// Возращает требующегося провайдера по индексу
    func getProvider(with index: Int) -> Provider
    
    /// Возвращает требующегося провайдера по уникальному идентификатору
    func getProvider(by id: Int) -> Provider?
    
    /// Возвращает количество найденных карт у провайдера
    func getCardCount(by providerID: Int) -> Int
    
    /// Возвращает карту провайдера по индексу провайдера
    func getCard(by index: Int, and providerID: Int) -> Card?
    
}
