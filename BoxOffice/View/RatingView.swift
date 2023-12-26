//
//  RatingView.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 26/12/2023.
//

import SwiftUI

import SwiftUI

struct RatingView: View {
    let movie: Movie

    var body: some View {
        let stars = HStack(spacing: 0) {
            ForEach(0..<5, id: \.self) { _ in
                Image(systemName: "star.fill")
            }
        }

        stars.overlay(
            GeometryReader { g in
                let width = CGFloat(movie.voteAverage) / CGFloat(10) * g.size.width
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: width)
                        .foregroundColor(.yellow)
                }
            }
            .mask(stars)
        )
        .foregroundColor(.white)
    }
}

#Preview {
    RatingView(movie: .example)
}
