//
//  MainView.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 27/12/2023.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
            PopularMoviesView()
                .tabItem {
                    Label("Popular", systemImage: "star")
                }

            FavouriteMoviesView()
                .tabItem {
                    Label("Favourites", systemImage: "heart")
                }
        }
    }
}

#Preview {
    MainView()
}
