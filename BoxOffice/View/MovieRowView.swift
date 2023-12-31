//
//  MovieRowView.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 31/12/2023.
//

import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    
    var body: some View {
        HStack(spacing: 15) {
            AsyncImage(url: movie.posterURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                
            }
            .frame(height: 100)
            
            VStack(alignment: .leading) {
                Text(movie.title)
                    .bold()
                    .lineLimit(2)
                Text(movie.overview)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(4)
            }
        }
    }
}

#Preview {
    MovieRowView(movie: .example)
}
