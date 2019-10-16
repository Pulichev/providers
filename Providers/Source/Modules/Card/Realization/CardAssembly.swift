//
//  CardAssembly.swift
//  Providers
//
//  Created by Victor Volnukhin on 16/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import Foundation

class CardAssembly: CardAssemblyProtocol {
    let card: Card
    
    required init(card: Card) {
        self.card = card
    }
    
    func configure(with viewController: CardViewController) {
        viewController.cardViewModel = CardViewModel(card: card)
    }
}
