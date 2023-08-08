//
//  NetworkService.swift
//  StarWarsSearchApp
//
//  Created by Nikita Marin on 05.08.2023.
//

import Alamofire

protocol NetworkService: AnyObject {
    func sendRequest<T: Codable>(
        endpoint: String,
        parameters: Parameters,
        completion: @escaping (Result<T, Error>) -> Void
    )
    func sendRequest<T: Codable>(
        to stringUrl: String,
        completion: @escaping (Result<T, Error>) -> Void
    )
}

final class NetworkServiceImpl: NetworkService {
    private let baseURL = "https://swapi.dev/api"
    
    func sendRequest<T: Codable>(
        endpoint: String,
        parameters: Parameters = [:],
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        AF.request(
            baseURL + endpoint,
            parameters: parameters
        )
        .validate()
        .responseDecodable { (response: DataResponse<T, AFError>) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func sendRequest<T: Codable>(
        to stringUrl: String,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        AF.request(stringUrl)
        .validate()
        .responseDecodable { (response: DataResponse<T, AFError>) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
