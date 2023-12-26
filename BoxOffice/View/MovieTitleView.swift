//
//  MovieTitleView.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 26/12/2023.
//

import SwiftUI

struct MovieTitleView: View {
    let movie: Movie
    
    let gradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: .black, location: 0),
            .init(color: .clear, location: 0.5)
        ]),
        startPoint: .bottom,
        endPoint: .top
    )
    
    var body: some View {
        AsyncImage(url: movie.imageURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            
        }
        .overlay {
            ZStack(alignment: .bottom) {
                gradient
                
                HStack(alignment: .top, spacing: 20) {
                    AsyncImage(url: movie.imageURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        
                    }
                    .border(.white, width: 1)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(movie.title)
                                .foregroundStyle(.white)
                                .font(.largeTitle)
                                .bold()
                                .lineLimit(2)
                                .minimumScaleFactor(0.5)
                            Text(movie.displayDate)
                                .foregroundStyle(.white)
                        }
                        RatingView(movie: movie)
                    }
                    
                    Spacer(minLength: 0)
                }
                .frame(height: 100)
                .padding()
            }
        }
    }
}

#Preview {
    MovieTitleView(movie: .example)
}
