//
//  Planet.swift
//  StarWarsSearchApp
//
//  Created by Nikita Marin on 08.08.2023.
//

import Foundation

struct Planets: Codable {
    let results: [Planet]
}

struct Planet: Codable {
    let name: String
    let diameter: String
    let population: String
    let films: [String]
}
