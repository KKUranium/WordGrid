//
//  GridModel.swift
//  WordGrid
//
//  Created by krishna on 18/08/19.
//  Copyright © 2019 Krishna. All rights reserved.
//

import Foundation

struct GridModel: Codable {
    let sourceLanguage: String?
    let word: String?
    let characterGrid: [[String]]?
    let wordLocations: [String: String]?
    let targetLanguage: String?
    
    private enum CodingKeys: String, CodingKey {
        case sourceLanguage = "source_language"
        case characterGrid = "character_grid"
        case word
        case wordLocations = "word_locations"
        case targetLanguage = "target_language"
        
    }
}
