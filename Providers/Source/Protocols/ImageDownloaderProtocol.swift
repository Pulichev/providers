//
//  ImageDownloaderProtocol.swift
//  Providers
//
//  Created by Victor Volnukhin on 07/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import RxSwift

protocol ImageDownloaderProtocol {


    // MARK: - Properties
    
    /// Параметр, публикующий данные о новом логотипе провайдера
    var imageData: PublishSubject<Data> { get }

    /// Параметр, публикующий данные об пришедшей ошибке с сервера
    var error: PublishSubject<String> { get }


    // MARK: - Functions
    
    /// Функция запрашивает картинку и с помощью замыкания позволяет работать с ней
    func downloadImage(for model: ImageableModelProtocol)
    
}
