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
            PopularListView()
                .tabItem {
                    Label("Popular", systemImage: "star")
                }
            
            SearchListView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            FavouriteListView()
                .tabItem {
                    Label("Favourites", systemImage: "heart")
                }
        }
    }
}

#Preview {
    MainView()
}
