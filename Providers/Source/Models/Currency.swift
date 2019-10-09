//
//  Currency.swift
//  Providers
//
//  Created by Victor Volnukhin on 04/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import Foundation

enum Currency: String {
    
    
    // MARK: - Cases
    
    case dollars = "USD"
    
    case euro = "EUR"
    
    
    // MARK: - Functions
    
    func print() -> String {
        switch self {
        case .dollars:
            return "$"
        case .euro:
            return "€"
        }
    }
}
