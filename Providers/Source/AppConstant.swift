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
            guard let path = Bundle.main.infoDictionary?["Providers Data URL"] as? String else { return String() }
            return path
        }
    }
    
    struct segues {
        static let toCardView: String = "toCardDescription"
    }
    
    struct urls {
        static let noImagePlaceholder = "no-image-placeholder"
        static let providersJson = Bundle.main.path(forResource: "providers", ofType: "json")
        static let bigdataJson = Bundle.main.path(forResource: "bigdata", ofType: "json")
    }
}
