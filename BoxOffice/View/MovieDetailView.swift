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
                Text("Overview")
                    .font(.title3)
                    .bold()
                Text(movie.overview)
                    .foregroundStyle(.secondary)
            }
            .padding()
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MovieDetailView(movie: .example)
}
