//
//  ProvidersTableViewCell.swift
//  Providers
//
//  Created by Victor Volnukhin on 03/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import UIKit

class ProvidersTableViewCell: UITableViewCell {
    
    
    // MARK: - Public fields
    
    var providerID: Int = 0
    
    
    // MARK: - Outlets

    @IBOutlet weak var providerTitleLabel: UILabel!
    @IBOutlet weak var cardsCollectionView: UICollectionView!

    
    // MARK: - Static properties
    
    static var identifier: String {
        return String(describing: self)
    }
    
    
    // MARK: - Public methods
    
    func setup(provider: Provider) {
        providerID = provider.id
        providerTitleLabel.text = provider.title
    }
    
}
