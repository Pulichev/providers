//
//  AlamofireNetworkService.swift
//  Providers
//
//  Created by Victor Volnukhin on 04/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import Alamofire

class AlamofireNetworkService: NetworkServiceProtocol {
    
    
    // MARK: - Public methods
    
    func sendRequest(url: URL, responseHandler: @escaping (Data?, Error?) -> Void) {
        Alamofire
            .request(url)
            .responseData { response in
                
                // Если не получилось получить ответ от сервера, то формируем ошибку
                if let error = response.error {
                    responseHandler(nil, error)
                    return
                }
                
                // Если получилось получить ответ от сервера, проверяем статус ответа
                switch response.result {
                case .success:
                    if let data = response.data {
                        responseHandler(data, nil)
                        return
                    }
                case .failure(let error):
                    responseHandler(nil, error)
                    return
                }
        }
    }
}
