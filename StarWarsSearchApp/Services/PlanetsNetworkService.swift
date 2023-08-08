//
//  PlanetsNetworkService.swift
//  StarWarsSearchApp
//
//  Created by Nikita Marin on 05.08.2023.
//

import Foundation

protocol PlanetsNetworkService: AnyObject {
    func getPlanets(
        name: String,
        completion: @escaping (Result<Planets, Error>) -> Void
    )
}

final class PlanetsNetworkServiceImpl: PlanetsNetworkService {
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkServiceImpl()) {
        self.networkService = networkService
    }
    
    func getPlanets(
        name: String,
        completion: @escaping (Result<Planets, Error>) -> Void
    ) {
        networkService.sendRequest(
            endpoint: "/planets/",
            parameters: [
                "search": name
            ],
            completion: completion
        )
    }
}
