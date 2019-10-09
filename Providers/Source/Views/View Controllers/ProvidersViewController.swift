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
    
    private lazy var providersViewModel: ProvidersViewModelProtocol & ImageDownloaderProtocol = ProvidersViewModel()
    
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
            .bind(to: providersTableView.rx.items(cellIdentifier: ProvidersTableViewCell.identifier,cellType: ProvidersTableViewCell.self)) {
                [weak self] row, provider, cell in
                guard let service = self?.providersViewModel else { return }
                cell.setup(provider: provider, imageDownloaderService: service)
            }
            .disposed(by: disposeBag)
    }

}
