//
//  ImageableModelProtocol.swift
//  Providers
//
//  Created by Victor Volnukhin on 07/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import Foundation

protocol ImageableModelProtocol {
    
    
    // MARK: - Properties
    
    /// Адрес, откуда брать картинку
    var imageURL: String { get set }
    
    /// Данные полученые по адресу
    var imageData: Data? { get set }
    
}
