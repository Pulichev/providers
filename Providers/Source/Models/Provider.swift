//
//  Provider.swift
//  Providers
//
//  Created by Victor Volnukhin on 03/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import Foundation

struct Provider: Codable {
    
    // MARK: - Public properties
    
    var id: Int
    var title: String
    var imageURL: String
    var giftCards: [Card]
    
    
    // MARK: - Initializers
    
    init(from decoder: Decoder) throws {
        let contrainer = try decoder.container(keyedBy: ProviderCodeingKey.self)
        id = try contrainer.decode(Int.self, forKey: .id)
        title = try contrainer.decode(String.self, forKey: .title)
        imageURL = try contrainer.decode(String.self, forKey: .imageURL)
        giftCards = try contrainer.decode(Array<Card>.self, forKey: .giftCards)
    }
    
    
    // MARK: - Public methods
    
    func encode(to encoder: Encoder) throws {
        var contrainer = encoder.container(keyedBy: ProviderCodeingKey.self)
        try contrainer.encode(id, forKey: .id)
        try contrainer.encode(title, forKey: .title)
        try contrainer.encode(imageURL, forKey: .imageURL)
        try contrainer.encode(giftCards, forKey: .giftCards)
    }
    
    
    // MARK: - Provider Coding Key
    
    private enum ProviderCodeingKey: String, CodingKey {
        case id = "id"
        case title = "title"
        case imageURL = "image_url"
        case giftCards = "gift_cards"
    }
}
