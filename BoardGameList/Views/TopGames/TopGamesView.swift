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
        TopGamesView(viewModel: TopGamesViewModelExample(loading: false))
            .background(Color.black)
    }
}

#if DEBUG
class TopGamesViewModelExample: TopGamesViewModelProtocol {
    @Published var games: [TopGamesGameViewData]
    @Published var loading: Bool
    
    init(games: [TopGamesGameViewData] = [TopGamesGameViewData(id: "j8LdPFmePE",
                                                               name: "7Wonders Duel",
                                                               imageUrl: "https://s3-us-west-1.amazonaws.com/5cc.images/games/uploaded/1629323024736.jpg",
                                                               rating: 3.5),
                                          TopGamesGameViewData(id: "i5Oqu5VZgP",
                                                               name: "azul",
                                                               imageUrl: "https://s3-us-west-1.ama…54200327-61EFZADvURL.jpg",
                                                               rating: 4.5)],
         loading: Bool = false) {
        self.games = games
        self.loading = loading
    }
    
    func viewDidLoad() {
    }
}
#endif
