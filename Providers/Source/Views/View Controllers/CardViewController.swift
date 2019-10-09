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
    
    
//    private var cardView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//    private var providerLogoImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//
//    private var codeLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private var creditsLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private var descriptionTextView: UITextView = {
//        let textview = UITextView()
//        textview.translatesAutoresizingMaskIntoConstraints = false
//        return textview
//    }()
    
    
    
    // MARK: - Public properties
    
    var card: Card! {
        didSet {
            print(card.id)
        }
    }
    
    
    // MARK: - Lifecycle View Controller

    override func viewDidLoad() {
        super.viewDidLoad()
//        addNeededSubviews()
//        addNeededConstraints()
        
        cardView.layer.borderWidth = 0.5
        cardView.layer.borderColor = UIColor.lightGray.cgColor
        cardView.layer.cornerRadius = 5
        
        if let imageData = Cache.instance[card.imageURL] {
            providerLogoImageView.image = UIImage(data: imageData)
        } else {
            providerLogoImageView.image = UIImage(named: AppConstant.urls.noImagePlaceholder)
        }
        
        let currency: String = Currency(rawValue: card.currency)?.print() ?? String()
        codesLabel.text = "\(currency)\(card.codesCount)"
        creditsLabel.text = "\(currency)\(card.credits)"
        descriptionTextView.text = card.description
    }
    
    
    // MARK: - Constraints
    
//    private func addNeededConstraints() {
//        addConstraintsForCardView()
//    }
//
//    private func addConstraintsForCardView() {
//        addContraintsForLogoImageView()
//        addConstraintsForCodesLabel()
//        addConstraintsForCreditsLabel()
//
//        cardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
//        cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
//
//    }
//
//    private func addContraintsForLogoImageView() {
//        providerLogoImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 4).isActive = true
//        providerLogoImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 4).isActive = true
//        providerLogoImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
//        providerLogoImageView.widthAnchor.constraint(equalToConstant: 85).isActive = true
//    }
//
//    private func addConstraintsForCodesLabel() {
//        codeLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 4).isActive = true
//        codeLabel.leadingAnchor.constraint(equalTo: providerLogoImageView.trailingAnchor, constant: 0).isActive = true
//        codeLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 0).isActive = true
//        codeLabel.centerYAnchor.constraint(equalTo: providerLogoImageView.centerYAnchor, constant: 0).isActive = true
//    }
//
//    private func addConstraintsForCreditsLabel() {
//        creditsLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 0).isActive = true
//        creditsLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 0).isActive = true
//        creditsLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 0).isActive = true
//        creditsLabel.topAnchor.constraint(equalTo: providerLogoImageView.bottomAnchor, constant: 5).isActive = true
//        creditsLabel.heightAnchor.constraint(equalToConstant: 27).isActive = true
//        creditsLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
//    }
//
//    private func addConstraintsForDescriptionTextView() {
//
//    }

    
    // MARK: - Private methods
    
//    private func addNeededSubviews() {
//        cardView.addSubview(providerLogoImageView)
//        cardView.addSubview(codeLabel)
//        cardView.addSubview(creditsLabel)
//
//        view.addSubview(cardView)
//        view.addSubview(descriptionTextView)
//    }
}
