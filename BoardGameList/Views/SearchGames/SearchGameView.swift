//
//  SearchGameView.swift
//  BoardGameList
//
//  Created by Thibaut Coutard on 30/01/2022.
//

import SwiftUI

struct SearchGameView<T>: View where T: SearchGamesViewModelProtocol {
    @ObservedObject var viewModel: T

    init(viewModel: T = SearchGamesViewModel() as! T) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.availableCategories) { category in
                    Text(category.name)
                        .padding()
                        .background(category.isSelected ? Color.green : Color.gray)
                        .cornerRadius(10)
                }
            }
        }.onAppear {
            viewModel.viewDidLoad()
        }
    }
}

struct SearchGame_Previews: PreviewProvider {
    static var previews: some View {
        SearchGameView(viewModel: SearchGamesViewModelExample())
    }
}

#if DEBUG
class SearchGamesViewModelExample: SearchGamesViewModelProtocol {
    @Published var availableCategories: [CategoryViewData]
    @Published var loading: Bool
    
    func viewDidLoad() {
    }
    
    init(availableCategories: [CategoryViewData] = [CategoryViewData(id: "id", name: "Adventure"),
                                                    CategoryViewData(id: "id2", name: "Puzzle", isSelected: true),
                                                    CategoryViewData(id: "id3", name: "Duo"),
                                                    CategoryViewData(id: "id4", name: "DeckBuilder")],
         loading: Bool = false) {
        self.availableCategories = availableCategories
        self.loading = loading
    }
}
#endif
