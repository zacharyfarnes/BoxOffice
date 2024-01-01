//
//  SearchListView-ViewModel.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 01/01/2024.
//

import Foundation

extension SearchListView {
    @MainActor class ViewModel: ObservableObject {
        @Published var navPath = [Movie]()
        
        @Published var movies = [Movie]()
        
        @Published var showingAlert = false
        @Published var alertMessage = ""
        
        @Published var searchText = ""
        
        func getMovies() async {
            do {
                movies = try await fetchMoviesFromAPI()
            } catch {
                if let error = error as? BOError {
                    alertMessage = error.alertMessage
                } else {
                    alertMessage = "An unknown error has occured."
                }
                showingAlert.toggle()
            }
        }
        
        func fetchMoviesFromAPI() async throws -> [Movie] {
            let urlString = "https://api.themoviedb.org/3/search/movie?query=\(searchText)&api_key=" + Constants.apiKey
            
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
                return try decoder.decode(PopularMovies.self, from: data).movies
            } catch {
                throw BOError.invalidData
            }
        }
    }
}
