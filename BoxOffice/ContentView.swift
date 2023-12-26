//
//  ContentView.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 26/12/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var movies = [Movie]()
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(movies) { movie in
                    HStack(spacing: 15) {
                        AsyncImage(url: movie.imageURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            
                        }
                        .frame(height: 100)

                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .bold()
                                .lineLimit(2)
                            Text(movie.overview)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .lineLimit(4)
                        }
                    }
                }
            }
            .listStyle(.plain)
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
            .navigationTitle("Popular")
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
            return try decoder.decode(Result.self, from: data).movies
        } catch {
            throw BOError.invalidData
        }
    }
}

struct Result: Codable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    
    var imageURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500/" + posterPath)!
    }
}

enum BOError: Error {
    case invalidURL, invalidResponse, invalidData
    
    var alertMessage: String {
        switch self {
        case .invalidURL:
            return "The URL for obtaining movies is invalid."
        case .invalidResponse:
            return "The response received from the server is invalid."
        case .invalidData:
            return "The data obtained from the server is invalid."
        }
    }
}

#Preview {
    ContentView()
}
