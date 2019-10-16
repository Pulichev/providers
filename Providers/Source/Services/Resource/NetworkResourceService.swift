//
//  NetworkResourceService.swift
//  Providers
//
//  Created by Victor Volnukhin on 09/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import RxSwift

class NetworkResourceService: ResourceServiceProtocol {
    
    
    // MARK: - Network properties
    
    /// Сервис обменивающийся информацией с сервером
    var networkService: NetworkServiceProtocol
    
    var error: PublishSubject<Error> = PublishSubject<Error>()
    
    
    
    // MARK: - Initializers
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    
    
    // MARK: - Public methods
    
    func loadDataFromResource(url: String, completionHandler: @escaping (Data?) -> Void) {
        guard let url = URL(string: url) else {
            print("URL is not valid.")
            error.onNext(NetworkError.invalidURL)
            completionHandler(nil)
            return
        }
        
        networkService.sendRequest(url: url) { [weak self] data, error in
            guard error == nil else {
                print("Server received an error.")
                self?.error.onNext(NetworkError.dontDownload)
                completionHandler(nil)
                return
            }
            
            if let data = data {
                print("Good data from server was received.")
                completionHandler(data)
            } else {
                print("Data from server is nil.")
                self?.error.onNext(NetworkError.dontDownload)
                completionHandler(nil)
            }
        }
    }
    
}
