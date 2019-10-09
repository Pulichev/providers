//
//  CardViewModelProtocol.swift
//  Providers
//
//  Created by Victor Volnukhin on 09/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import Foundation

protocol CardViewModelProtocol {
    
    
    // MARK: - Properties
    
    // UI:
    var borderWidth: Float { get }
    var cornerRadius: Float { get }
    
    /// Загружается логотип провайдера из кэша
    var imageData: Data? { get }
    
    var codes: String { get }
    var credits: String { get }
}
