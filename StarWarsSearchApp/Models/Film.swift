//
//  Film.swift
//  StarWarsSearchApp
//
//  Created by Nikita Marin on 08.08.2023.
//

import Foundation

struct Films: Codable {
    let results: [Film]
}

struct Film: Codable {
    let title: String
    let episodeId: Int
    let director: String
    let producer: String
    
    enum CodingKeys: String, CodingKey {
        case title, director, producer
        case episodeId = "episode_id"
    }
}
