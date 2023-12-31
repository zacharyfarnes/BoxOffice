//
//  PopularListView.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 26/12/2023.
//

import SwiftUI

struct PopularListView: View {
    @State private var navPath = [Movie]()
    
    @State private var movies = [Movie]()
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack(path: $navPath) {
            List {
                ForEach(movies) { movie in
                    NavigationLink(value: movie) {
                        MovieRowView(movie: movie)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Popular")
            .refreshable {
                await getMovies()
            }
            .task {
                await getMovies()
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Error loading movies"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationDestination(for: Movie.self) { movie in
                MovieDetailView(movie: movie)
            }
        }
    }
    
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
        let urlString = "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&api_key=" + Constants.apiKey
        
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

#Preview {
    PopularListView()
}
