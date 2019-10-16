//
//  Cache.swift
//  Providers
//
//  Created by Victor Volnukhin on 09/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import Foundation

class Cache {
    
    
    // MARK: - Static properties
    
    static let instance: Cache = Cache()
    
    
    // MARK: - Cachable properties
    
    /// Кэш, в котором будут храниться данные по логотипам провайдеров
    private let imageCache = NSCache<NSString, NSData>()
    
    
    
    // MARK: - Initializers
    
    private init() { }
    
    
    // MARK: - Subscripts
    
    subscript(key: String) -> Data? {
        get {
            guard let nsdata = imageCache.object(forKey: NSString(string: key)) else { return nil }
            return Data(nsdata)
        }
        set (newValue) {
            if let object = newValue {
                imageCache.setObject(NSData(data: object), forKey: NSString(string: key))
            } else {
                imageCache.removeObject(forKey: NSString(string: key))
            }
        }
    }
}
