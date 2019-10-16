//
//  ResourceServiceProtocol.swift
//  Providers
//
//  Created by Victor Volnukhin on 09/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import Foundation

protocol ResourceServiceProtocol {
    
    
    // MARK: - Functions
    
    /// Возвращает данные о запрошенном ресурсе
    func loadDataFromResource(url: String, completionHandler: @escaping (Data?) -> Void)
    
}
