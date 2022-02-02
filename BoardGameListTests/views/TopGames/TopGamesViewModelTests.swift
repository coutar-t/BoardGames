//
//  TopGamesViewModelTests.swift
//  BoardGameListTests
//
//  Created by Thibaut Coutard on 30/01/2022.
//

import XCTest
import OHHTTPStubs
import Combine
@testable import BoardGameList

class TopGamesViewModelTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    func test_whenViewDidLoad_thenLoading() {
        let viewModel = TopGamesViewModel()
        
        XCTAssertFalse(viewModel.loading)
        viewModel.viewDidLoad()
        XCTAssertTrue(viewModel.loading)
    }
    
    func test_whenViewDidLoad_thenRetrieveTopGames() {
        self.mockTopGames(with: 200, value:
        """
        {
            "games": [
                {
                    "id": "TAAifFP590",
                    "name": "Root",
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
        """)
        
        let viewModel = TopGamesViewModel()
        viewModel.viewDidLoad()
        
        let updateExpectations = expectation(description: "wait for games to be updated")
        viewModel.$games
            .dropFirst()
            .sink { games in
                XCTAssertEqual(games, [TopGamesGameViewData(id: "TAAifFP590", name: "Root", imageUrl: "https://s3-us-west-1.amazonaws.com/5cc.images/games/uploaded/1629324760985.jpg", rating: 4.066092779896466)])
                XCTAssertFalse(viewModel.loading)
                updateExpectations.fulfill()
            }.store(in: &cancellables)
        
        wait(for: [updateExpectations], timeout: 10)
    }
    
}

extension TopGamesGameViewData: Equatable {
    public static func == (lhs: TopGamesGameViewData, rhs: TopGamesGameViewData) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.imageUrl == rhs.imageUrl &&
        lhs.rating == rhs.rating
    }
}
