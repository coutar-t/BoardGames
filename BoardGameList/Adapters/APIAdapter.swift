//
//  APIAdapter.swift
//  BoardGameList
//
//  Created by Thibaut Coutard on 29/01/2022.
//

import Foundation

//sourcery: AutoMockable
public protocol APIAdapter {
    func get(url: URL, completion: @escaping (Result<Data, APIError>) -> Void)
}

public enum APIError: Error {
    case unknown
    case malformedUrl
}

class APIURLSessionAdapter {
    var currentTask: URLSessionDataTask?
}

extension APIURLSessionAdapter: APIAdapter {
    func get(url: URL, completion: @escaping (Result<Data, APIError>) -> Void) {
        let currentTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    completion(Result.failure(APIError.unknown))
                }
                if let data = data {
                    completion(Result.success(data))
                }
            }
        }
        currentTask.resume()
    }
}
