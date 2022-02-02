//
//  SearchGamesViewModelTests.swift
//  BoardGameListTests
//
//  Created by Thibaut Coutard on 30/01/2022.
//

import XCTest
import OHHTTPStubs
import Combine
@testable import BoardGameList

// Recherche par nom, age mini, joueurs mini, max playtime, category

class SearchGamesViewModelTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }

    func defaultMockGetCategories() {
        self.mockGetCategories(with: 200, value:
            """
            {
              "categories": [
                {
                  "id": "KzEQIwIub7",
                  "name": "Historic",
                  "url": "https://www.boardgameatlas.com/category/KzEQIwIub7/historic"
                },
                {
                  "id": "cAIkk5aLdQ",
                  "name": "Horror",
                  "url": "https://www.boardgameatlas.com/category/cAIkk5aLdQ/horror"
                },
                {
                  "id": "TYnxiuiI3X",
                  "name": "Humor",
                  "url": "https://www.boardgameatlas.com/category/TYnxiuiI3X/humor"
                },
                {
                  "id": "herNFAxMdz",
                  "name": "Music",
                  "url": "https://www.boardgameatlas.com/category/herNFAxMdz/music"
                }
              ]
            }
            """
        )
    }
    
    func test_whenViewDidLoad_thenRefreshCategories() {
        Adapters.injector = AdapterMockInjector.default

        let viewModel = SearchGamesViewModel()
        self.defaultMockGetCategories()
        
        XCTAssertFalse(viewModel.loading)
        viewModel.viewDidLoad()
        XCTAssertTrue(viewModel.loading)
        
        let updateExpectations = expectation(description: "wait for categories to be updated")
        viewModel.$availableCategories
            .dropFirst()
            .sink { categories in
                XCTAssertEqual(categories, [CategoryViewData(id: "KzEQIwIub7", name: "Historic"),
                                            CategoryViewData(id: "cAIkk5aLdQ", name: "Horror"),
                                            CategoryViewData(id: "TYnxiuiI3X", name: "Humor"),
                                            CategoryViewData(id: "herNFAxMdz", name: "Music")])
                XCTAssertFalse(viewModel.loading)
                updateExpectations.fulfill()
            }.store(in: &cancellables)
        
        wait(for: [updateExpectations], timeout: 10)
    }
    
    func test_whenSearchByName_thenGamesAreReturned() {
        let apiMock = APIAdapterMock()
        apiMock.getUrlCompletionClosure = { _, closure in
            closure(.success(
            """
            {
            "games": [
                {
                    "id": "TAAifFP590",
                    "name": "7 Wonders",
                    "min_players": 2,
                    "max_players": 4,
                    "min_playtime": 60,
                    "max_playtime": 90,
                    "min_age": 10,
                    "description": "description",
                    "image_url": "https://s3-us-west-1.amazonaws.com/5cc.images/games/uploaded/1629324760985.jpg",
                    "average_user_rating": 4.066092779896466
                }
            ],
            "count": 131368
            }
            """.data(using: .utf8)!))
        }
        let adapterInjector = AdapterMockInjector.default
        adapterInjector.saveAdapter(type: APIAdapter.self, adapter: apiMock)
        Adapters.injector = adapterInjector

        let viewModel = SearchGamesViewModel()

        viewModel.searchName = "7 Wonders"
        viewModel.search()

        XCTAssertTrue(apiMock.getUrlCompletionCalledOnlyAndOnce)
        XCTAssertEqual(apiMock.getUrlCompletionReceivedArguments?.url.absoluteString, "https://api.boardgameatlas.com/api/search?name=7%20Wonders&fuzzy_match=true&client_id=5livxIP9K0")

        let updateExpectations = expectation(description: "wait for Games to be updated")
        viewModel.$games
            .sink { games in
                XCTAssertEqual(games, [SearchGameGameViewData(id: "TAAifFP590", name: "7 Wonders")])
                XCTAssertFalse(viewModel.loading)
                updateExpectations.fulfill()
            }.store(in: &cancellables)

        wait(for: [updateExpectations], timeout: 10)
    }
}

extension SearchGameGameViewData: Equatable {
    public static func == (lhs: SearchGameGameViewData, rhs: SearchGameGameViewData) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name

    }
}

extension CategoryViewData: Equatable {
    public static func == (lhs: CategoryViewData, rhs: CategoryViewData) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name
        
    }
}
