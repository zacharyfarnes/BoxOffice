//
//  ContentView.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 26/12/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var navPath = [Movie]()
    
    var body: some View {
        NavigationStack(path: $navPath) {
            PopularListView()
                .navigationDestination(for: Movie.self) { movie in
                    MovieDetailView(movie: movie)
                }
        }
    }
}

#Preview {
    ContentView()
}
