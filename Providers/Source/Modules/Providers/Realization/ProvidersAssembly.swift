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
        let chosenResourceService: ResourceServiceProtocol = chooseNeededResourceService()
        viewController.providersViewModel = ProvidersViewModel(resourceService: chosenResourceService)
    }
    
    
    // MARK: - Private methods
    
    /// Функция выбора конкретного варианта загрзчика данных из ресурсов
    private func chooseNeededResourceService() -> ResourceServiceProtocol {
        // Для использования файлов в папке приложения Assets, выберете класс AssetsResourcesService.
        // Для скачивания файлов с сервера - класс AlamofireResourceService.
        return AppConstant.config.isLoadDataFromFile ? AssetsResourceService() : AlamofireResourceService()
    }
}
