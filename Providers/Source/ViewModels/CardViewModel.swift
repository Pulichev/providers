//
//  CardViewModel.swift
//  Providers
//
//  Created by Victor Volnukhin on 09/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import Foundation

class CardViewModel: CardViewModelProtocol {
    
    
    // MARK: - Private fields
    
    private let card: Card
    
    
    
    // MARK: - Initializers
    
    init(card: Card) {
        self.card = card
    }
    
    
    
    // MARK: - Public properties
    
    var borderWidth: Float {
        return 0.5
    }
    
    var cornerRadius: Float {
        return 5
    }
    
    var imageData: Data? {
        return Cache.instance[card.imageURL]
    }
    
    var codes: String {
        return "\(currency)\(card.codesCount)"
    }
    
    var credits: String {
        return "\(currency)\(card.credits)"
    }
    
    
    // MARK: - Private properties
    
    private var currency: String {
        return Currency(rawValue: card.currency)?.print() ?? String()
    }
}
