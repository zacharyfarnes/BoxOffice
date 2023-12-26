//
//  Result.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 26/12/2023.
//

import Foundation

struct Result: Codable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
