//
//  BoardGameListApp.swift
//  BoardGameList
//
//  Created by Thibaut Coutard on 29/01/2022.
//

import SwiftUI

@main
struct BoardGameListApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
    
    init() {
        UINavigationBar.appearance().backgroundColor = UIColor(red: 35.0/255.0, green: 37.0/255.0, blue: 35.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = .white
    }
}
