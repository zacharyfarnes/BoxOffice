//
//  Movie.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 26/12/2023.
//

import Foundation

struct Movie: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let posterPath: String
    let backdropPath: String
    let voteAverage: Float
    
    var displayDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: releaseDate) else {
            return "Unknown Date"
        }
        formatter.dateFormat = "E, d MMM y"
        return formatter.string(from: date)
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500/" + posterPath)!
    }
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500/" + backdropPath)!
    }
    
    static let example = Movie(
        id: 11,
        title: "Star Wars",
        overview: "Princess Leia is captured and held hostage by the evil Imperial forces in their effort to take over the galactic Empire. Venturesome Luke Skywalker and dashing captain Han Solo team together with the loveable robot duo R2-D2 and C-3PO to rescue the beautiful princess and restore peace and justice in the Empire.", 
        releaseDate: "1977-05-25",
        posterPath: "6FfCtAuVAW8XJjZ7eWeLibRLWTw.jpg",
        backdropPath: "4qCqAdHcNKeAHcK8tJ8wNJZa9cx.jpg",
        voteAverage: 8.205
    )
}
