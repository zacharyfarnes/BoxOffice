//
//  FavouriteView.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 27/12/2023.
//

import SwiftUI

struct FavouriteRowView: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            AsyncImage(url: movie.posterURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Color.secondary
                    .overlay {
                        Image(systemName: "camera")
                            .foregroundColor(.white)
                    }
            }
            .frame(width: 140, height: 210)
            
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
    FavouriteRowView(movie: .example)
}
