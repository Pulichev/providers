//
//  CardAssemblyProtocol.swift
//  Providers
//
//  Created by Victor Volnukhin on 16/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import Foundation

protocol CardAssemblyProtocol {
    /// Карта, детальную информацию о которой хотим посмотреть
    init(card: Card)
    
    /// Сконфигурировать детализированный экран карты
    func configure(with viewController: CardViewController)
}
