//
//  FavouriteMoviesView.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 27/12/2023.
//

import SwiftUI

struct FavouriteMoviesView: View {
    @State private var navPath = [Movie]()
    
    var body: some View {
        NavigationStack(path: $navPath) {
            FavouriteListView()
                .navigationDestination(for: Movie.self) { movie in
                    MovieDetailView(movie: movie)
                }
                .navigationTitle("Favourites")
        }
    }
}

#Preview {
    FavouriteMoviesView()
}
