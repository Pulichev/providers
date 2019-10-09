//
//  ImageDownloaderProtocol.swift
//  Providers
//
//  Created by Victor Volnukhin on 07/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import RxSwift

protocol ImageDownloaderProtocol {
    
    /// Функция запрашивает картинку и с помощью замыкания позволяет работать с ней
    func downloadImage(url: String, completionHandler: @escaping (Data?) -> Void)
    
}
