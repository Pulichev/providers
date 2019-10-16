//
//  ProvidersAssembly.swift
//  Providers
//
//  Created by Victor Volnukhin on 16/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import Foundation

class ProvidersAssembly: ProvidersAssemblyProtocol {
    
    
    // MARK: - Public methods
    
    func configure(with viewController: ProvidersViewController) {
        viewController.providersViewModel =
            ProvidersViewModel(resourceService: chooseNeededResourceService(), networkService: chooseNeededNetworkService())
    }
    
    
    // MARK: - Private methods
    
    /// Функция выбора конкретного варианта загрзчика данных из ресурсов
    private func chooseNeededResourceService() -> ResourceServiceProtocol {
        // Для использования файлов в папке приложения Assets, выберете класс AssetsResourcesService.
        // Для скачивания файлов с сервера - класс AlamofireResourceService.
        return AppConstant.config.isLoadDataFromFile ? AssetsResourceService() : NetworkResourceService(networkService: chooseNeededNetworkService())
    }
    
    private func chooseNeededNetworkService() -> NetworkServiceProtocol {
        // Тут можно реализовать логику выбора сетевого протокола.
        // В качестве примера: класс AlamofireNetworkService - c использованием соответствующего пода
        return RxNetworkService() // AlamofireNetworkService()
    }
    
}

