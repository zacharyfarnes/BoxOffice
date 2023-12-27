//
//  Favourites.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 27/12/2023.
//

import SwiftUI

class Favorites: ObservableObject {
    private var movies: Set<Int>
    private let saveKey = "Favorites"

    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedMovies = try? JSONDecoder().decode(Set<Int>.self, from: data) {
                movies = decodedMovies
                return
            }
        }
        
        movies = []
    }
    
    func get() -> Set<Int> {
        return movies
    }

    func contains(_ movie: Movie) -> Bool {
        movies.contains(movie.id)
    }

    func add(_ movie: Movie) {
        objectWillChange.send()
        movies.insert(movie.id)
        save()
    }

    func remove(_ movie: Movie) {
        objectWillChange.send()
        movies.remove(movie.id)
        save()
    }

    func save() {
        if let data = try? JSONEncoder().encode(movies) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }
}
