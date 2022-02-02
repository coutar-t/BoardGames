//
//  TopGamesViewTests.swift
//  BoardGameListTests
//
//  Created by Thibaut Coutard on 30/01/2022.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import BoardGameList

class TopGamesViewTests: XCTestCase {
    override func setUp() {
//        isRecording = true
        Adapters.injector = AdapterMockInjector.default
    }
    
    func test_topGamesView_loading() {
        let testedView = TopGamesView(viewModel: TopGamesViewModelExample(games: [], loading: true)).background(Color.black)
        let view: UIView = UIHostingController(rootView: testedView).view
        
        assertSnapshot(matching: view, as: .image(size: view.intrinsicContentSize))
    }

    func test_topGamesView_Games() {
        let testedView = TopGamesView(viewModel: TopGamesViewModelExample(games: [TopGamesGameViewData(id: "j8LdPFmePE", name: "7 Wonders Duel", imageUrl: "https://s3-us-west-1.amazonaws.com/5cc.images/games/uploaded/1629323024736.jpg", rating: 3.5),
                                                                            TopGamesGameViewData(id: "i5Oqu5VZgP", name: "azul", imageUrl: "https://s3-us-west-1.amazonaws.com/5cc.images/games/uploaded/1559254200327-61EFZADvURL.jpg", rating: 4.5)], loading: false)).background(Color.black)
        let view: UIView = UIHostingController(rootView: testedView).view

        assertSnapshot(matching: view, as: .image(size: view.intrinsicContentSize))
    }

    func test_topGamesViewWithLoadingImages_Games() {
        let mock = AdapterMockInjector()
        mock.saveAdapter(type: ImageFetcher.self, adapter: ImageFetcherMock())

        Adapters.injector = mock

        let testedView = TopGamesView(viewModel: TopGamesViewModelExample(games: [TopGamesGameViewData(id: "j8LdPFmePE", name: "7 Wonders Duel", imageUrl: "https://s3-us-west-1.amazonaws.com/5cc.images/games/uploaded/1629323024736.jpg", rating: 3.5),
                                                                                  TopGamesGameViewData(id: "i5Oqu5VZgP", name: "azul", imageUrl: "https://s3-us-west-1.amazonaws.com/5cc.images/games/uploaded/1559254200327-61EFZADvURL.jpg", rating: 4.5)], loading: false)).background(Color.black)
        let view: UIView = UIHostingController(rootView: testedView).view

        assertSnapshot(matching: view, as: .image(size: view.intrinsicContentSize))
    }
}
