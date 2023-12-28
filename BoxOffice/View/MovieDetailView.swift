//
//  MovieDetailView.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 26/12/2023.
//

import SwiftUI

struct MovieDetailView: View {
    @EnvironmentObject var favorites: Favorites
    
    let movie: Movie
    
    var body: some View {
        ScrollView {
            MovieTitleView(movie: movie)
            
            Button(action: {
                if favorites.contains(movie) {
                    favorites.remove(movie)
                } else {
                    favorites.add(movie)
                }
            }, label: {
                favorites.contains(movie) ?
                Text("Remove from Favourites")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 5)
                    .transaction { transaction in
                        transaction.animation = nil
                    }
                :
                Text("Add to Favourites")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 5)
                    .transaction { transaction in
                        transaction.animation = nil
                    }
            })
            .buttonStyle(.bordered)
            .padding()
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Overview")
                        .font(.title3)
                        .bold()
                    Text(movie.overview)
                        .foregroundStyle(.secondary)
                }
                .padding([.horizontal, .bottom])
                
                VStack(alignment: .leading) {
                    Text("Cast")
                        .font(.title3)
                        .bold()
                        .padding(.leading)
                    ActorListView(movie: movie)
                }
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    MovieDetailView(movie: .example)
        .environmentObject(Favorites())
}
