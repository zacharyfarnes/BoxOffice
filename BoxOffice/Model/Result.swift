//
//  Result.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 26/12/2023.
//

import Foundation

struct PopularMovies: Codable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Credits: Codable {
    let actors: [Actor]
    
    enum CodingKeys: String, CodingKey {
        case actors = "cast"
    }
}
