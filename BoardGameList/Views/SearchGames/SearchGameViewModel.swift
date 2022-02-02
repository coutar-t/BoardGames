//
//  SearchGameViewModel.swift
//  BoardGameList
//
//  Created by Thibaut Coutard on 30/01/2022.
//

import Foundation

class SearchGamesViewModelProtocol: ObservableObject {
    @Published var games: [SearchGameGameViewData] = []
    @Published var availableCategories: [CategoryViewData] = []
    @Published var loading: Bool = false
    @Published var searchName: String = ""
//    var searchCategories: [CategoryViewData] { get }
//    var minPlayer:
    
    func viewDidLoad() {}
    func search() {}
    fileprivate init() {}
}

class SearchGamesViewModel: SearchGamesViewModelProtocol {
    private var gameListAPI: GameListAPIWrapperProtocol
    
    init(gameListAPI: GameListAPIWrapperProtocol = GameListAPIWrapper()) {
        self.gameListAPI = gameListAPI
        super.init()
    }

    override func viewDidLoad() {
        loading = true
        self.gameListAPI.getCategories { result in
            self.loading = false
            switch result {
            case .success(let categories):
                self.availableCategories = categories.compactMap({ CategoryViewData(id: $0.id, name: $0.name) })
            case .failure(let error): break
            }
        }
    }

    override func search() {
        self.gameListAPI.getSearchGames(name: searchName) { result in
            switch result {
            case .success(let games):
                self.games = games.compactMap({ SearchGameGameViewData(id: $0.id, name: $0.name) })
            case .failure(let error): break
            }
        }
    }
}

struct SearchGameGameViewData {
    var id: String
    var name: String
}

struct CategoryViewData {
    var id: String
    var name: String
}
