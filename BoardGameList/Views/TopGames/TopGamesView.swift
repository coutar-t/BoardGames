//
//  TopGamesView.swift
//  BoardGameList
//
//  Created by Thibaut Coutard on 29/01/2022.
//

import SwiftUI

struct TopGamesView<T>: View where T: TopGamesViewModelProtocol {
    @ObservedObject var viewModel: T
    
    init(viewModel: T = TopGamesViewModel() as! T) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Popular")
                .sectionTitle()
            if viewModel.loading {
                progressView
            } else {
                gameListView
            }
        }
        .padding()
        .onAppear {
            viewModel.viewDidLoad()
        }
    }
}

extension TopGamesView {
    var progressView: some View {
        return ProgressView()
            .progressViewStyle(.circular)
            .foregroundColor(.white)
    }

    var gameListView: some View {
        return ScrollView(.horizontal) {
            HStack(alignment: .top, spacing: 14.0) {
                ForEach(viewModel.games) { game in
                    TopGamesGameCell(game: game)
                }
            }
        }
    }
}

struct TopGamesView_Previews: PreviewProvider {
    static var previews: some View {
        Adapters.injector = AdapterMockInjector.default
        return TopGamesView(viewModel: TopGamesViewModelExample())
            .background(Color.black)
    }
}
