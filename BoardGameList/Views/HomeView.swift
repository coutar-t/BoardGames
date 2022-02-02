//
//  HomeView.swift
//  BoardGameList
//
//  Created by Thibaut Coutard on 29/01/2022.
//

import SwiftUI

struct HomeView: View {
    @State var showingSearch: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                TopGamesView<TopGamesViewModel>()
                Spacer()
            }.background {
                Color(red: 35.0/255.0, green: 37.0/255.0, blue: 35.0/255.0)
            }.navigationTitle("Games")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button {
                        showingSearch.toggle()
                    } label: {
                        Label("Search", systemImage: "magnifyingglass")
                            .font(Font.system(size: 12))
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(red: 96.0/255.0, green: 164.0/255.0, blue: 82.0/255.0))
                            .frame(width: 30, height: 30)
                            .cornerRadius(15)
                    }
                }
                .sheet(isPresented: $showingSearch) {
                    SearchGameView()
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
