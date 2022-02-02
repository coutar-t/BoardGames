//
//  SearchGameViewModel.swift
//  BoardGameList
//
//  Created by Thibaut Coutard on 30/01/2022.
//

import Foundation

protocol SearchGamesViewModelProtocol: ObservableObject {
//    var games: [TopGamesGameViewData] { get }
    var availableCategories: [CategoryViewData] { get }
    var loading: Bool { get }
//    var searchName: String { get }
//    var searchCategories: [CategoryViewData] { get }
//    var minPlayer:
    
    func viewDidLoad()
}

class SearchGamesViewModel: SearchGamesViewModelProtocol {
    @Published var loading: Bool = false
    @Published var availableCategories: [CategoryViewData] = []
    private var gameListAPI: GameListAPIWrapperProtocol
    
    init(gameListAPI: GameListAPIWrapperProtocol = GameListAPIWrapper()) {
        self.gameListAPI = gameListAPI
    }

    func viewDidLoad() {
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
}

struct CategoryViewData {
    var id: String
    var name: String
}
