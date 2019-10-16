//
//  Int+Extension.swift
//  Providers
//
//  Created by Victor Volnukhin on 16/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import Foundation

extension Int {
    
    func currency(_ currency: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        let number = NSNumber(value: self)
        return formatter.string(from: number) ?? String(self)
    }
    
}
