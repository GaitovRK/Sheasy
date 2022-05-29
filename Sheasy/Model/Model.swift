//
//  Model.swift
//  Sheasy
//
//  Created by Rashid Gaitov on 29.05.2022.
//

import Foundation
struct Recipe: Codable {
    
    let publisher: String
    
    let url: URL
    
    let sourceUrl: String
    
    let id: String
    
    let title: String
    
    let imageUrl: String
    
    let socialRank: Double
    
    let publisherUrl: URL
}

enum CodingKeys: String, CodingKey {
    case publisher

    case url = "f2f_url"
    
    case sourceUrl = "source_url"
    
    case id = "recipe_id"
    
    case title
    
    case imageUrl = "image_url"
    
    case socialRank = "social_rank"
    
    case publisherUrl = "publisher_url"
    }

