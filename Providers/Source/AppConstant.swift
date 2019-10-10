//
//  AppConstant.swift
//  Providers
//
//  Created by Victor Volnukhin on 04/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import Foundation

struct AppConstant {
    
    struct api {
        static var path: String {
            // Загружать из файла?
            if config.isLoadDataFromFile {
                
                // Если да, то пытаемся получить имя файла из конфига
                guard let assetsFileName = Bundle.main.infoDictionary?["Providers Json File Name"] as? String else { return String() }
                // Получаем путь к файл в ассетах
                guard let pathToJsonFile = Bundle.main.path(forResource: assetsFileName, ofType: "json") else { return String () }
                return pathToJsonFile
                
            } else {
                // Если нет, то пытаемся получить ссылку на сервер, откуда возьмём данные о провайдерах
                guard let path = Bundle.main.infoDictionary?["Providers Data URL"] as? String else { return String() }
                return path
            }
        }
    }
    
    struct segues {
        static let toCardView: String = "toCardDescription"
    }
    
    struct urls {
        static let noImagePlaceholder = "no-image-placeholder"
    }
    
    struct config {
        static var isLoadDataFromFile: Bool {
            guard let isLoadDataFromFile = Bundle.main.infoDictionary?["Load Data from File"] as? Bool else { return false }
            return isLoadDataFromFile
        }
    }
}
