//
//  FavouritesView.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 27/12/2023.
//

import SwiftUI

struct FavouriteListView: View {
    @EnvironmentObject var favorites: Favorites
    
    @StateObject private var viewModel = ViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack(path: $viewModel.navPath) {
            Group {
                if !viewModel.sortedMovies.isEmpty {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewModel.sortedMovies, id: \.self) { movie in
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
                            viewModel.showingSortOptions = true
                        } label: {
                            Label("Change sort order", systemImage: "arrow.up.arrow.down")
                        }
                    }
                    .confirmationDialog("Sort order", isPresented: $viewModel.showingSortOptions) {
                        Button("Default") { viewModel.sortType = .default }
                        Button("Alphabetical") { viewModel.sortType = .alphabetical }
                        Button("Release Date") { viewModel.sortType = .releaseDate }
                    }
                } else {
                    if viewModel.searchText.isEmpty {
                        Text("No Favourites Added")
                            .foregroundStyle(.secondary)
                    } else {
                        ContentUnavailableView.search
                    }
                }
            }
            .searchable(text: $viewModel.searchText)
            .navigationTitle("Favourites")
            .refreshable {
                await viewModel.getMovies(for: favorites.get())
            }
            .task {
                await viewModel.getMovies(for: favorites.get())
            }
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(
                    title: Text("Error loading favourites"),
                    message: Text(viewModel.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationDestination(for: Movie.self) { movie in
                MovieDetailView(movie: movie)
            }
        }
    }
}

#Preview {
    FavouriteListView()
        .environmentObject(Favorites.example)
}
