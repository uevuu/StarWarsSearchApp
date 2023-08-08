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
