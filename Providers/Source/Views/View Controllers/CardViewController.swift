//
//  CardViewController.swift
//  Providers
//
//  Created by Victor Volnukhin on 05/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var providerLogoImageView: UIImageView!
    @IBOutlet weak var codesLabel: UILabel!
    @IBOutlet weak var creditsLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    // MARK: - Public fields
    
    var card: Card!
    private var cardViewModel: CardViewModelProtocol!
    
    
    
    // MARK: - Lifecycle View Controller

    override func viewDidLoad() {
        super.viewDidLoad()
        cardViewModel = CardViewModel(card: card)
        setupNeededProperties()
    }

    
    
    // MARK: - Private methods
    
    private func setupNeededProperties() {
        setupCardViewProperties()
        setupProviderLogoFromCache()
        setupOutputLabelsProperties()
    }
    
    private func setupCardViewProperties() {
        cardView.layer.borderWidth = CGFloat(cardViewModel.borderWidth)
        cardView.layer.borderColor = UIColor.lightGray.cgColor
        cardView.layer.cornerRadius = CGFloat(cardViewModel.cornerRadius)
    }
    
    private func setupProviderLogoFromCache() {
        activityIndicator.stopAnimating()
        guard let imageData = cardViewModel.imageData else {
            providerLogoImageView.image = UIImage(named: AppConstant.urls.noImagePlaceholder)
            return
        }
        providerLogoImageView.image = UIImage(data: imageData)
    }
    
    private func setupOutputLabelsProperties() {
        codesLabel.text = cardViewModel.codes
        creditsLabel.text = cardViewModel.credits
        descriptionTextView.text = card.description
    }
}
