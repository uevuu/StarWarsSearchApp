//
//  Starship.swift
//  StarWarsSearchApp
//
//  Created by Nikita Marin on 08.08.2023.
//

import Foundation

struct Starships: Codable {
    let results: [Starship]
}

struct Starship: Codable {
    let name: String
    let model: String
    let manufacturer: String
    let passengers: String
    let films: [String]
}
