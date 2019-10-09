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
    
    
    // MARK: - Static properties
    
    static var identifier: String {
        return String(describing: self)
    }
    
    
    // MARK: - Public methods
    
    func setup(card: Card, imageDownloaderService service: ImageDownloaderProtocol) {
        codeLabel.text = String(card.codesCount)
        creditsLabel.text = String(card.credits)
        service.downloadImage(url: card.imageURL) { [weak self] data in
            guard let data = data else {
                self?.providerImageView.image = UIImage(named: "no-image-placeholder")
                return
            }
            self?.providerImageView.image = UIImage(data: data)
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
