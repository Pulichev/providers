//
//  ProvidersTableViewCell.swift
//  Providers
//
//  Created by Victor Volnukhin on 03/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import UIKit
import RxSwift

class ProvidersTableViewCell: UITableViewCell {
    
    
    // MARK: - Public fields
    
    var cards: Observable<[Card]>!
    private var disposeBag = DisposeBag()
    
    
    // MARK: - Outlets

    @IBOutlet weak var providerTitleLabel: UILabel!
    @IBOutlet weak var cardsCollectionView: UICollectionView!

    
    // MARK: - Static properties
    
    static var identifier: String {
        return String(describing: self)
    }
    
    
    // MARK: - Public methods
    
    func setup(provider: Provider) {
        providerTitleLabel.text = provider.title
        
        // Для каждой ячейке data source и delegate должны определяться собственные
        cardsCollectionView.delegate = nil
        cardsCollectionView.dataSource = nil
        
        cards = Observable.from(optional: provider.giftCards)
    }
    
}
