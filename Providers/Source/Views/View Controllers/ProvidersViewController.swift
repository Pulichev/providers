//
//  ProvidersTableViewController.swift
//  Providers
//
//  Created by Victor Volnukhin on 03/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProvidersViewController: UIViewController {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var providersTableView: UITableView!
    
    @IBOutlet weak var cardsCollectionView: UICollectionView!
    
    
    // MARK: - Private fields
    
    private lazy var providersViewModel: RxProvidersViewModelProtocol & ImageDownloaderProtocol = ProvidersViewModel()
    
    private var disposeBag = DisposeBag()
    
    
    
    // MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Запрашиваем данные о провайдерах
        providersViewModel.getProviders()
        
        setupProviderCellConfiguration()
    }
    
    
    
    // MARK: - Reactive table view
    
    private func setupProviderCellConfiguration() {
        providersViewModel.providers
            .bind(to:
                providersTableView
                    .rx
                    .items(
                        cellIdentifier: ProvidersTableViewCell.identifier,
                        cellType: ProvidersTableViewCell.self)) { [weak self] row, provider, cell in
                            guard let service = self?.providersViewModel else { return }
                            cell.setup(provider: provider, imageDownloaderService: service)
                        }
                    .disposed(by: disposeBag)
    }
    

    
    // MARK: - Table view data source

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return providersViewModel.providersCount
//    }
//
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // Проверим, что правильно задан идентификатор ячейки в сториборде
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProvidersTableViewCell.identifier, for: indexPath) as? ProvidersTableViewCell else {
//            fatalError("ProvidersTableViewCell cannot be created. The identifier in the storyboard may be incorrect.")
//        }
//
//        let currentProvider = providersViewModel.getProvider(with: indexPath.row)
//        cell.setup(provider: currentProvider)
//        return cell
//    }

}


//extension ProvidersViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//
//
//    // MARK: - Collection view data source
//
//    private func getProviderIDFromSuperview(of collectionView: UICollectionView) -> Int {
//        // Получаем с супервью идентификатор провайдера и проводим требующиеся операции с картами.
//        //
//        // Есть и другие варианты решения этой задачи - например, определять по нажатию пользователя на ячейку
//        // с помощью функционала UIResponder, но я считаю, что такой метод усложнит в данном случае, как разработку
//        // функционала, так и его поддержку.
//        guard let superViewCell = collectionView.superview?.superview as? ProvidersTableViewCell else {
//            fatalError("CollectionView is not superview of needed TableViewCell.")
//        }
//        return superViewCell.providerID
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let providerID = getProviderIDFromSuperview(of: collectionView)
//        return providersViewModel.getCardCount(by: providerID)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        // Проверим, что правильно задан идентификатор ячейки в сториборде
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardsCollectionViewCell.identifier, for: indexPath) as? CardsCollectionViewCell else {
//            fatalError("CardsCollectionViewCell cannot be created. The identifier in the storyboard may be incorrect.")
//        }
//
//        let providerID = getProviderIDFromSuperview(of: collectionView)
//        if let currentCard = providersViewModel.getCard(by: indexPath.row, and: providerID) {
//            // Установка значений кода и кредитов,
//            // а также сервис, который можно использовать для загрузки изображений
//            cell.setup(card: currentCard, imageDownloaderService: providersViewModel)
//        }
//
//        return cell
//    }
//
//
//    // MARK: - Collction view flow layout
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 150, height: 80)
//    }
//}
