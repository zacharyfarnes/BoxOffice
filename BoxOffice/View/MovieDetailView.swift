//
//  MovieDetailView.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 26/12/2023.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    
    var body: some View {
        ScrollView {
            MovieTitleView(movie: movie)
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Overview")
                        .font(.title3)
                        .bold()
                    Text(movie.overview)
                        .foregroundStyle(.secondary)
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text("Cast")
                        .font(.title3)
                        .bold()
                        .padding(.leading)
                    ActorListView(movie: movie)
                }
                .padding(.bottom, 50)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MovieDetailView(movie: .example)
}
