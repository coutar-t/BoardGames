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
        let adapterInjector = AdapterMockInjector()
        Adapters.injector = adapterInjector

        let viewModel = SearchGamesViewModel()

        viewModel.name = "7 Wonders"
        viewModel.search()




    }
}

extension CategoryViewData: Equatable {
    public static func == (lhs: CategoryViewData, rhs: CategoryViewData) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name
        
    }
}
