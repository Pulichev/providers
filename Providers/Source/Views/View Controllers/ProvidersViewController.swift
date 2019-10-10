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
    
    
    // MARK: - Private fields
    
    private lazy var providersViewModel: ProvidersViewModelProtocol & CachableImageDownloaderProtocol = ProvidersViewModel()
    
    private var disposeBag = DisposeBag()
    
    
    
    // MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Запрашиваем данные о провайдерах
        providersViewModel.getProviders()
        // Настраиваем конфигурации ячеек
        setupProviderCellConfiguration()
    }
    
    
    
    // MARK: - Reactive table view
    
    private func setupProviderCellConfiguration() {
        providersViewModel.providers
            .bind(to: providersTableView.rx.items(cellIdentifier: ProvidersTableViewCell.identifier,cellType: ProvidersTableViewCell.self)) {
                [weak self] row, provider, cell in
                cell.setup(provider: provider)
                self?.setupCollectionItemConfiguration(for: cell)
                self?.setupCollectionItemSelected(for: cell, with: provider)
            }
            .disposed(by: disposeBag)
    }
    
    
    // MARK: - Reactive collection view
    
    func setupCollectionItemConfiguration(for cell: ProvidersTableViewCell) {
        cell.cards.bind(to: cell.cardsCollectionView.rx.items(cellIdentifier: CardsCollectionViewCell.identifier, cellType: CardsCollectionViewCell.self)) {
            [weak self] row, card, cell in
            guard let service = self?.providersViewModel else { return }
            cell.setup(card: card, imageDownloaderService: service)
        }.disposed(by: disposeBag)
    }
    
    func setupCollectionItemSelected(for cell: ProvidersTableViewCell, with provider: Provider) {
        cell.cardsCollectionView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.performSegue(withIdentifier: AppConstant.segues.toCardView, sender: provider.giftCards[indexPath.row])
        }).disposed(by: disposeBag)
    }

    
    
    // MARK: - Navigation methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == AppConstant.segues.toCardView else { return }
        guard let cardViewController = segue.destination as? CardViewController else { return }
        guard let chosenCard = sender as? Card else { return }
        
        cardViewController.card = chosenCard
    }
}
