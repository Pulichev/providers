//
//  CardViewController.swift
//  Providers
//
//  Created by Victor Volnukhin on 05/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    
    // MARK: - Constants
    
    let cardBorderWidth: CGFloat = 0.5
    let cardCornerRadius: CGFloat = 5
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var providerLogoImageView: UIImageView!
    @IBOutlet weak var codesLabel: UILabel!
    @IBOutlet weak var creditsLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    // MARK: - Public fields
    
    var cardAssembly: CardAssemblyProtocol!
    var cardViewModel: CardViewModelProtocol!
    
    
    
    // MARK: - Lifecycle View Controller

    override func viewDidLoad() {
        super.viewDidLoad()
        cardAssembly.configure(with: self)
        setupNeededProperties()
    }

    
    
    // MARK: - Private methods
    
    private func setupNeededProperties() {
        setupCardViewProperties()
        setupProviderLogoFromCache()
        setupOutputLabelsProperties()
    }
    
    private func setupCardViewProperties() {
        cardView.layer.borderWidth = cardBorderWidth
        cardView.layer.borderColor = UIColor.lightGray.cgColor
        cardView.layer.cornerRadius = cardCornerRadius
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
        descriptionTextView.text = cardViewModel.description
    }
}
