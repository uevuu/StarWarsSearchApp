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
