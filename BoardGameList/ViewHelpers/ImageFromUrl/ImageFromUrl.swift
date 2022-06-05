//
//  ImageFromUrl.swift
//  BoardGameList
//
//  Created by Thibaut Coutard on 31/01/2022.
//

import SwiftUI

struct ImageFromUrl: View {
    var url: URL
    @ObservedObject var imageFetcher: ImageFetcher

    var body: some View {
        Group {
        if let image = imageFetcher.image {
            Image(uiImage: image)
                .resizable()
        } else {
            ProgressView()
                .progressViewStyle(.circular)
                .foregroundColor(.white)
        }
        }.onAppear {
            imageFetcher.load(url: url)
        }
    }

    init(url: URL, imageFetcher: ImageFetcher = SimpleImageFetcher()) {
        self.url = url
        self.imageFetcher = imageFetcher
    }
}

struct AsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        ImageFromUrl(url: URL(string: "https://google.com")!,
                     imageFetcher: ImageFetcherMock(image: UIImage(named:"ImageExample")))
    }
}
