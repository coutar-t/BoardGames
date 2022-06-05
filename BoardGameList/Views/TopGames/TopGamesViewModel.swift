//
//  TopGamesViewModel.swift
//  BoardGameList
//
//  Created by Thibaut Coutard on 30/01/2022.
//

import Foundation

protocol TopGamesViewModelProtocol: ObservableObject {
    var games: [TopGamesGameViewData] { get }
    var loading: Bool { get }
    
    func viewDidLoad()
}

class TopGamesViewModel: TopGamesViewModelProtocol {
    @Published var games: [TopGamesGameViewData] = []
    @Published var loading: Bool = false
    private var gameListAPI: GameListAPIWrapperProtocol
    
    init(gameListAPI: GameListAPIWrapperProtocol = GameListAPIWrapper()) {
        self.gameListAPI = gameListAPI
    }
    
    func viewDidLoad() {
        loading = true
        
        gameListAPI.getTopGames { result in
            self.loading = false
            switch result {
            case .success(let games):
                self.games = games.compactMap({ TopGamesGameViewData(from: $0)})
            case .failure(_):
                break
            }
        }
    }
}

struct TopGamesGameViewData: Identifiable {
    var id: String
    var name: String
    var imageUrl: String
    var rating: Double
    
    init(id: String,
         name: String,
         imageUrl: String,
         rating: Double) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.rating = rating
    }
    
    fileprivate init(from: APIGame) {
        self.id = from.id
        self.name = from.name
        self.imageUrl = from.imageUrl
        self.rating = from.averageUserRating
    }
}
