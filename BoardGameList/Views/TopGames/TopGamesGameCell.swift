//
//  TopGamesGameCell.swift
//  BoardGameList
//
//  Created by Thibaut Coutard on 31/01/2022.
//

import Foundation
import SwiftUI

struct TopGamesGameCell: View {
    var game: TopGamesGameViewData

    var body: some View {
        VStack(alignment: .leading) {
            ImageFromUrl(url: URL(string: game.imageUrl)!)
                .cornerRadius(10.0)
                .frame(width: 100, height: 100)
            Text(game.name)
                .foregroundColor(.white)
            Text("Rating: \(game.rating, specifier: "%.1f")")
                .font(.subheadline)
                .foregroundColor(Color.white.opacity(0.7))

        }
        .frame(width: 100)
    }
}

struct TopGamesGameCell_Previews: PreviewProvider {
    static var previews: some View {
        TopGamesGameCell(game: TopGamesGameViewData(id: "j8LdPFmePE",
                                                    name: "7Wonders Duel",
                                                    imageUrl: "https://s3-us-west-1.amazonaws.com/5cc.images/games/uploaded/1629323024736.jpg",
                                                    rating: 3.5))
            .background(Color.black)
    }
}
