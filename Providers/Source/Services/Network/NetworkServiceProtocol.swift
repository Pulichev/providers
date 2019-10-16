//
//  NetworkServiceProtocol.swift
//  Providers
//
//  Created by Victor Volnukhin on 04/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    
    /// Функция отправки запроса на сервер
    /// - parameters:
    ///     - url: адрес, на который будет отправлен запрос
    ///     - responseHandler: метод по обработке отвера от сервера
    func sendRequest(url: URL, responseHandler: @escaping (Data?, Error?) -> Void)
    
}
