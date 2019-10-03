//
//  ProvidersTableViewController.swift
//  Providers
//
//  Created by Victor Volnukhin on 03/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import UIKit

class ProvidersTableViewController: UITableViewController {
    
    
    // MARK: - Private fields
    
    private lazy var providersViewModel: ProvidersViewModelProtocol = ProvidersViewModel()
    
    
    // MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        providersViewModel.getProviders()
    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return providersViewModel.providersCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Проверим, что правильно задан идентификатор ячейки в сториборде
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProvidersTableViewCell.identifier, for: indexPath) as? ProvidersTableViewCell else {
            fatalError("ProvidersTableViewCell cannot be created. The identifier in the storyboard may be incorrect.")
        }

        let currentProvider = providersViewModel.getProvider(with: indexPath.row)
        cell.setup(provider: currentProvider, collectionViewDataSourceDelegate: self)
        return cell
    }

}

extension ProvidersTableViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    // MARK: - Collection view data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return providersViewModel.getCardsCount(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Проверим, что правильно задан идентификатор ячейки в сториборде
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardsCollectionViewCell.identifier, for: indexPath) as? CardsCollectionViewCell else {
            fatalError("CardsCollectionViewCell cannot be created. The identifier in the storyboard may be incorrect.")
        }
        
        let currentCard = providersViewModel.getCard(in: indexPath.section, with: indexPath.row)
        cell.setup(card: currentCard)
        return cell
    }
    
}
