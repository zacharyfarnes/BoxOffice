//
//  FavouriteListView-ViewModel.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 01/01/2024.
//

import Foundation

extension FavouriteListView {
    @MainActor class ViewModel: ObservableObject {
        @Published var navPath = [Movie]()
        
        @Published var movies = [Movie]()
        
        @Published var showingAlert = false
        @Published var alertMessage = ""
        
        @Published var searchText = ""
        
        @Published var sortType = SortType.default
        @Published var showingSortOptions = false
        
        var sortedMovies: [Movie] {
            var sortedMovies = movies
            
            if !searchText.isEmpty {
                sortedMovies = movies.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
            }
            
            switch sortType {
            case .default:
                return sortedMovies.sorted { $0.id < $1.id }
            case .alphabetical:
                return sortedMovies.sorted { $0.title < $1.title }
            case .releaseDate:
                return sortedMovies.sorted { $0.date < $1.date }
            }
        }
        
        func getMovies(for favoriteMovies: Set<Int>) async {
            do {
                movies = try await fetchMoviesFromAPI(for: favoriteMovies)
            } catch {
                if let error = error as? BOError {
                    alertMessage = error.alertMessage
                } else {
                    alertMessage = "An unknown error has occured."
                }
                showingAlert.toggle()
            }
        }
        
        func fetchMoviesFromAPI(for favoriteMovies: Set<Int>) async throws -> [Movie] {
            var fetchedMovies = [Movie]()
            
            for favourite in favoriteMovies {
                let urlString = "https://api.themoviedb.org/3/movie/\(favourite)?language=en-US&api_key=" + Constants.apiKey
                
                guard let url = URL(string: urlString) else {
                    throw BOError.invalidURL
                }
                
                let (data, response) = try await URLSession.shared.data(from: url)
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw BOError.invalidResponse
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    let movie = try decoder.decode(Movie.self, from: data)
                    fetchedMovies.append(movie)
                } catch {
                    throw BOError.invalidData
                }
            }
            
            return fetchedMovies
        }
    }
}
