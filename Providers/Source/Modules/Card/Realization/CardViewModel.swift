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
    
    var imageData: Data? {
        return Cache.instance[card.imageURL]
    }
    
    var codes: String {
        return card.codesCount.currency(card.currency)
    }
    
    var credits: String {
        return card.credits.currency(card.currency)
    }
    
    var description: String {
        return card.description
    }

}
