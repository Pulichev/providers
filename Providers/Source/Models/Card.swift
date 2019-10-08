//
//  Card.swift
//  Providers
//
//  Created by Victor Volnukhin on 03/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import Foundation

class Card: Codable, ImageableModelProtocol {
    
    // MARK: - Codable properties
    
    var id: Int
    var featured: Bool
    var title: String
    var credits: Int
    var imageURL: String
    var codesCount: Int
    var currency: String
    var description: String
    var redeemURL: String
    
    // MARK: - Additional properties
    
    /// Параметр, хранящий данные по логотипу провайдера
    var imageData: Data?
    
    
    // MARK: - Initializers
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CardCodingKey.self)
        id = try container.decode(Int.self, forKey: .id)
        featured = try container.decode(Bool.self, forKey: .featured)
        title = try container.decode(String.self, forKey: .title)
        credits = try container.decode(Int.self, forKey: .credits)
        imageURL = try container.decode(String.self, forKey: .imageURL)
        codesCount = try container.decode(Int.self, forKey: .codesCount)
        currency = try container.decode(String.self, forKey: .currency)
        description = try container.decode(String.self, forKey: .description)
        redeemURL = try container.decode(String.self, forKey: .redeemURL)
    }
    
    
    // MARK: - Public methods
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CardCodingKey.self)
        try container.encode(id, forKey: .id)
        try container.encode(featured, forKey: .featured)
        try container.encode(title, forKey: .title)
        try container.encode(credits, forKey: .credits)
        try container.encode(imageURL, forKey: .imageURL)
        try container.encode(codesCount, forKey: .codesCount)
        try container.encode(currency, forKey: .currency)
        try container.encode(description, forKey: .description)
        try container.encode(redeemURL, forKey: .redeemURL)
    }
    
    
    // MARK: - Coding Keys Enum
    
    private enum CardCodingKey: String, CodingKey {
        case id = "id"
        case featured = "featured"
        case title = "title"
        case credits = "credits"
        case imageURL = "image_url"
        case codesCount = "codes_count"
        case currency = "currency"
        case description = "description"
        case redeemURL = "redeem_url"
    }
}
