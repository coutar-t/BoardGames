//
//  GameListAPIWrapper.swift
//  BoardGameList
//
//  Created by Thibaut Coutard on 29/01/2022.
//

import Foundation

protocol GameListAPIWrapperProtocol {
    func getTopGames(_ completion: @escaping (Result<[APIGame], Error>) -> Void)
    func getCategories(_ completion: @escaping (Result<[APICategory], Error>) -> Void)
}

class GameListAPIWrapper: GameListAPIWrapperProtocol {
    private var clientId: String = "5livxIP9K0"
    private var clientSecret: String = "ca74bc7d9c0505fbb453ff469e99dd7c"
    private let apiAdapter: APIAdapter
    
    init(apiAdapter: APIAdapter = Adapters.injector.getAdapter(type: APIAdapter.self)) {
        self.apiAdapter = apiAdapter
    }
    
    func getTopGames(_ completion: @escaping (Result<[APIGame], Error>) -> Void) {
        guard let url = URL(string: "https://api.boardgameatlas.com/api/search?limit=10&pretty=true&client_id=\(clientId)&order_by=rank") else {
            return completion(.failure(APIError.malformedUrl))
        }
        
        apiAdapter.get(url: url) { result in
            switch result {
            case .failure(let error): completion(.failure(error))
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(APIGameList.self, from: data)
                    completion(.success(result.games))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getCategories(_ completion: @escaping (Result<[APICategory], Error>) -> Void) {
        guard let url = URL(string: "https://api.boardgameatlas.com/api/game/categories?pretty=true&client_id=\(clientId)") else {
            return completion(.failure(APIError.malformedUrl))
        }
        
        apiAdapter.get(url: url) { result in
            switch result {
            case .failure(let error): completion(.failure(error))
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(APICategoryList.self, from: data)
                    completion(.success(result.categories))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        
    }
}

struct APICategoryList: Codable {
    var categories: [APICategory]
}

struct APICategory: Codable {
    var id: String
    var name: String
}

struct APIGameList: Codable {
    var games: [APIGame]
    var count: Int
}

struct APIGame: Codable {
    var name: String
    var id: String
    var imageUrl: String
    var description: String
    var minPlayers: Int
    var maxPlayers: Int
    var minAge: Int
    var minPlaytime: Int
    var maxPlaytime: Int
    var averageUserRating: Double
}
