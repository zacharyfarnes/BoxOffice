//
//  FavouriteView.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 27/12/2023.
//

import SwiftUI

struct FavouriteView: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            AsyncImage(url: movie.posterURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Image(systemName: "camera")
            }
            .frame(height: 200)
            
            Text(movie.title)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
                .bold()
            
            Spacer()
        }
        .frame(width: 200)
    }
}

#Preview {
    FavouriteView(movie: .example)
}
