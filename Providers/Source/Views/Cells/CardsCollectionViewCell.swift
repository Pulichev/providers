//
//  CardsCollectionViewCell.swift
//  Providers
//
//  Created by Victor Volnukhin on 03/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import UIKit

class CardsCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var providerImageView: UIImageView!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var creditsLabel: UILabel!
    
    
    // MARK: - Static properties
    
    static var identifier: String {
        return String(describing: self)
    }
    
    
    // MARK: - Public methods
    
    func setup(card: Card) {
        codeLabel.text = String(card.codesCount)
        creditsLabel.text = String(card.credits)
    }
    
    
    // MARK: - Override methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 5
    }
}
