//
//  AlamofireResourceService.swift
//  Providers
//
//  Created by Victor Volnukhin on 09/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import Foundation

class AlamofireResourceService: ResourceServiceProtocol {
    
    
    // MARK: - Network properties
    
    /// Сервис обменивающийся информацией с сервером
    var networkService: NetworkServiceProtocol = AlamofireNetworkService()
    
    
    
    // MARK: - Public methods
    
    func loadDataFromResource(url: String, completionHandler: @escaping (Data?) -> Void) {
        guard let url = URL(string: url) else {
            print("URL is not valid.")
            completionHandler(nil)
            return
        }
        
        networkService.sendRequest(url: url) { data, error in
            guard error == nil else {
                print("Server received an error.")
                completionHandler(nil)
                return
            }
            
            if let data = data {
                print("Good data from server was received.")
                completionHandler(data)
            } else {
                print("Data from server is nil.")
                completionHandler(nil)
            }
        }
    }
    
}
