//
//  StarshipsNetworkService.swift
//  StarWarsSearchApp
//
//  Created by Nikita Marin on 05.08.2023.
//

import Foundation

protocol StarshipsNetworkService: AnyObject {
    func getStarships(
        name: String,
        completion: @escaping (Result<Starships, Error>) -> Void
    )
}

final class StarshipsNetworkServiceImpl: StarshipsNetworkService {
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkServiceImpl()) {
        self.networkService = networkService
    }
    
    func getStarships(
        name: String,
        completion: @escaping (Result<Starships, Error>) -> Void
    ) {
        networkService.sendRequest(
            endpoint: "/starships/",
            parameters: [
                "search": name
            ],
            completion: completion
        )
    }
}

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
