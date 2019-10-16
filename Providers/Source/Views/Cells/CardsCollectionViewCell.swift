//
//  CardsCollectionViewCell.swift
//  Providers
//
//  Created by Victor Volnukhin on 03/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import UIKit
import RxSwift

class CardsCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var providerImageView: UIImageView!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var creditsLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: - Static properties
    
    static var identifier: String {
        return String(describing: self)
    }
    
    
    // MARK: - Public methods
    
    func setup(card: Card, imageDownloaderService service: CachableImageDownloaderProtocol) {
        //let currency: String = Currency(rawValue: card.currency)?.print() ?? String()
        codeLabel.text = card.codesCount.currency(card.currency) //"\(currency)\(card.codesCount)"
        creditsLabel.text = card.credits.currency(card.currency) //"\(currency)\(card.credits)"
        service.downloadImage(url: card.imageURL) { [weak self] data in
            let chosenImage = data != nil ? UIImage(data: data!) : UIImage(named: AppConstant.urls.noImagePlaceholder)
            self?.activityIndicator.stopAnimating()
            self?.providerImageView.image = chosenImage
        }
    }
    
    
    // MARK: - Override methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 5
    }

}
