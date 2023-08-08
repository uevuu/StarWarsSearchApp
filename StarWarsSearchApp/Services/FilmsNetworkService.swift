//
//  FilmsNetworkService.swift
//  StarWarsSearchApp
//
//  Created by Nikita Marin on 07.08.2023.
//

import Foundation

protocol FilmsNetworkService: AnyObject {
    func getFilmInfo(
        with url: String,
        completion: @escaping (Result<Film, Error>) -> Void
    )
}

final class FilmsNetworkServiceImpl: FilmsNetworkService {
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkServiceImpl()) {
        self.networkService = networkService
    }
    
    func getFilmInfo(
        with url: String,
        completion: @escaping (Result<Film, Error>) -> Void
    ) {
        networkService.sendRequest(to: url, completion: completion)
    }
}
