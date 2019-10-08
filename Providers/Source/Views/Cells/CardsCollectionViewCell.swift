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
    
    
    // MARK: - Fields
    
    private var imageData = Observable<Data>.just(Data())
    private var disposeBag = DisposeBag()
    
    //var provider: Provider!
    
    
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
        addObserverForLoadingImage(from: service)
        service.downloadImage(for: card)
    }
    
    
    // MARK: - Override methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 5
    }
    
    
    // MARK: - Observers
    
    private func addObserverForLoadingImage(from service: ImageDownloaderProtocol) {
//        print("Add new observer for cell with codes (\(codeLabel.text)) and credits (\(creditsLabel.text))")
        
        //service.imageData.bind(to: providerImageView.rx.image
        
        
//        imageData
//            .bind(to: service.imageData.asObservable().subscribe(onNext: { [weak self] (data) in
//                guard let imageView = self?.providerImageView else { return }
//                imageView.image = UIImage(data: data)
//            }))
//            .disposed(by: disposeBag)
//
        service
            .imageData
            .asObservable()
            .subscribe(onNext: { [weak self] (data) in
                print("New value for cell with codes (\(self?.codeLabel.text)) and credits (\(self?.creditsLabel.text))")
                print("Data, bytes: \(data)")
                self?.providerImageView.image = UIImage(data: data)
            })
            .disposed(by: disposeBag)
    }
}
