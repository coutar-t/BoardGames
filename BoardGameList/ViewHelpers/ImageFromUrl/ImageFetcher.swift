//
//  ImageFetcher.swift
//  BoardGameList
//
//  Created by Thibaut Coutard on 31/01/2022.
//

import Foundation
import Combine
import UIKit

class ImageFetcher: ObservableObject {
    @Published var image: UIImage?
    func load(url: URL) {}

    fileprivate init() {}
}

class SimpleImageFetcher: ImageFetcher {
    internal override init() {
        super.init()
    }

    override func load(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                self?.image = UIImage(data: data)
            }
        }
        task.resume()
    }
}

#if DEBUG

class ImageFetcherMock: ImageFetcher {
    override func load(url: URL) {}

    init(image: UIImage? = nil) {
        super.init()
        self.image = image
    }
}

#endif
