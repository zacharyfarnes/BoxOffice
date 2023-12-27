//
//  Actor.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 26/12/2023.
//

import Foundation

struct Actor: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let character: String
    let profilePath: String?
    
    var profileURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500/" + (profilePath ?? ""))
    }
    
    static let example = Actor(
        id: 2,
        name: "Mark Hamill",
        character: "Luke Skywalker",
        profilePath: "2ZulC2Ccq1yv3pemusks6Zlfy2s.jpg"
    )
}
