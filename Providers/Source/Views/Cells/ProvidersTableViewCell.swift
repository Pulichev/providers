//
//  ProvidersTableViewCell.swift
//  Providers
//
//  Created by Victor Volnukhin on 03/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import UIKit

class ProvidersTableViewCell: UITableViewCell {
    
    
    // MARK: - Outlets

    @IBOutlet weak var providerTitleLabel: UILabel!
    @IBOutlet weak var cardsCollectionView: UICollectionView!

    
    // MARK: - Static properties
    
    static var identifier: String {
        return String(describing: self)
    }
    
    
    // MARK: - Public methods
    
    func setup(provider: Provider, collectionViewDataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate) {
        providerTitleLabel.text = provider.title
        cardsCollectionView.dataSource = collectionViewDataSourceDelegate
        cardsCollectionView.delegate = collectionViewDataSourceDelegate
        cardsCollectionView.reloadData()
    }
    
}
