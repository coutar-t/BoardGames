//
//  APIStubs.swift
//  BoardGameListTests
//
//  Created by Thibaut Coutard on 30/01/2022.
//

import Foundation
import OHHTTPStubs
import XCTest
@testable import BoardGameList

extension XCTest {
    private var clientId: String { "5livxIP9K0" }
    func mockTopGames(with code: Int, value: String) {
        stub(condition: { req in req.url?.absoluteString == "https://api.boardgameatlas.com/api/search?limit=10&pretty=true&client_id=\(self.clientId)&order_by=rank"}) { _ in
            return HTTPStubsResponse(data: value.data(using: .utf8)!, statusCode: Int32(code), headers: nil)
        }
    }
    
    func mockGetCategories(with code: Int, value: String) {
        stub(condition: { req in req.url?.absoluteString == "https://api.boardgameatlas.com/api/game/categories?pretty=true&client_id=\(self.clientId)"}) { _ in
            return HTTPStubsResponse(data: value.data(using: .utf8)!, statusCode: Int32(code), headers: nil)
        }
    }
}
