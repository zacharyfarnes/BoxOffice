//
//  ActorListView-ViewModel.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 31/12/2023.
//

import Foundation

extension ActorListView {
    @MainActor class ViewModel: ObservableObject {
        let movie: Movie
        
        @Published var actors = [Actor]()
        
        @Published var showingAlert = false
        @Published var alertMessage = ""
        
        init(movie: Movie) {
            self.movie = movie
        }
        
        func getActors() async {
            do {
                actors = try await fetchActorsFromAPI()
            } catch {
                if let error = error as? BOError {
                    alertMessage = error.alertMessage
                } else {
                    alertMessage = "An unknown error has occured."
                }
                showingAlert.toggle()
            }
        }
        
        func fetchActorsFromAPI() async throws -> [Actor] {
            let urlString = "https://api.themoviedb.org/3/movie/\(movie.id)/credits?language=en-US&api_key=" + Constants.apiKey
            
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
                return try decoder.decode(Credits.self, from: data).actors
            } catch {
                throw BOError.invalidData
            }
        }
    }
}
