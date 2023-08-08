//
//  CharactersNetworkService.swift
//  StarWarsSearchApp
//
//  Created by Nikita Marin on 05.08.2023.
//

import Foundation

protocol CharactersNetworkService: AnyObject {
    func getCharacters(
        name: String,
        completion: @escaping (Result<Characters, Error>) -> Void
    )
}

final class CharactersNetworkServiceImpl: CharactersNetworkService {
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkServiceImpl()) {
        self.networkService = networkService
    }
    
    func getCharacters(
        name: String,
        completion: @escaping (Result<Characters, Error>) -> Void
    ) {
        networkService.sendRequest(
            endpoint: "/people/",
            parameters: [
                "search": name
            ],
            completion: completion
        )
    }
}

struct Characters: Codable {
    let results: [Character]
}

struct Character: Codable {
    let name: String
    let gender: String
    let starshipsCount: Int
    let films: [String]
    
    enum CodingKeys: String, CodingKey {
        case name, gender, films
        case starshipsCount = "starships"
    }
    
    init (
        name: String,
        gender: String,
        starshipsCount: Int,
        films: [String]
    ) {
        self.name = name
        self.gender = gender
        self.starshipsCount = starshipsCount
        self.films = films
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.gender = try container.decode(String.self, forKey: .gender)
        self.starshipsCount = try container.decode([String].self, forKey: .starshipsCount).count
        self.films = try container.decode([String].self, forKey: .films)
    }
}
