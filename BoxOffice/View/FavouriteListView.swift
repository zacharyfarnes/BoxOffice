//
//  FavouritesView.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 27/12/2023.
//

import SwiftUI

struct FavouriteListView: View {
    @EnvironmentObject var favorites: Favorites
    @State private var navPath = [Movie]()
    
    @State private var movies = [Movie]()
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    @State private var searchText = ""
    
    @State private var sortType = SortType.default
    @State private var showingSortOptions = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
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
    
    var body: some View {
        NavigationStack(path: $navPath) {
            Group {
                if !sortedMovies.isEmpty {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(sortedMovies, id: \.self) { movie in
                                NavigationLink(value: movie) {
                                    FavouriteRowView(movie: movie)
                                        .foregroundColor(.primary)
                                }
                            }
                        }
                        .padding()
                    }
                    .toolbar {
                        Button {
                            showingSortOptions = true
                        } label: {
                            Label("Change sort order", systemImage: "arrow.up.arrow.down")
                        }
                    }
                    .confirmationDialog("Sort order", isPresented: $showingSortOptions) {
                        Button("Default") { sortType = .default }
                        Button("Alphabetical") { sortType = .alphabetical }
                        Button("Release Date") { sortType = .releaseDate }
                    }
                } else {
                    if searchText.isEmpty {
                        Text("No Favourites Added")
                            .foregroundStyle(.secondary)
                    } else {
                        ContentUnavailableView.search
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Favourites")
            .refreshable {
                await getMovies()
            }
            .task {
                await getMovies()
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Error loading favourites"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationDestination(for: Movie.self) { movie in
                MovieDetailView(movie: movie)
            }
        }
    }
    
    enum SortType {
        case `default`, alphabetical, releaseDate
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
        var fetchedMovies = [Movie]()
        
        for favourite in favorites.get() {
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

#Preview {
    FavouriteListView()
        .environmentObject(Favorites.example)
}
