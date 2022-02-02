//
//  TopGamesViewModel.swift
//  BoardGameList
//
//  Created by Thibaut Coutard on 30/01/2022.
//

import Foundation

class TopGamesViewModelProtocol: ObservableObject {
    @Published var games: [TopGamesGameViewData] = []
    @Published var loading: Bool = false
    
    func viewDidLoad() {}

    fileprivate init() {}
}

class TopGamesViewModel: TopGamesViewModelProtocol {
    private var gameListAPI: GameListAPIWrapperProtocol
    
    init(gameListAPI: GameListAPIWrapperProtocol = GameListAPIWrapper()) {
        self.gameListAPI = gameListAPI
        super.init()
    }
    
    override func viewDidLoad() {
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

#if DEBUG
class TopGamesViewModelExample: TopGamesViewModelProtocol {
    init(games: [TopGamesGameViewData] = [TopGamesGameViewData(id: "j8LdPFmePE",
                                                               name: "7Wonders Duel",
                                                               imageUrl: "https://s3-us-west-1.amazonaws.com/5cc.images/games/uploaded/1629323024736.jpg",
                                                               rating: 3.5),
                                          TopGamesGameViewData(id: "i5Oqu5VZgP",
                                                               name: "azul",
                                                               imageUrl: "https://s3-us-west-1.ama…54200327-61EFZADvURL.jpg",
                                                               rating: 4.5)],
         loading: Bool = false) {
        super.init()
        self.games = games
        self.loading = loading
    }

    override func viewDidLoad() {
    }
}
#endif
