//
//  SearchListView.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 01/01/2024.
//

import SwiftUI

struct SearchListView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.navPath) {
            Group {
                if !viewModel.movies.isEmpty {
                    List {
                        ForEach(viewModel.movies) { movie in
                            NavigationLink(value: movie) {
                                MovieRowView(movie: movie)
                            }
                        }
                    }
                    .listStyle(.plain)
                } else {
                    ContentUnavailableView.search
                }
            }
            .navigationTitle("Search")
            .searchable(text: $viewModel.searchText)
            .onChange(of: viewModel.searchText, {
                Task {
                    await viewModel.getMovies()
                }
            })
            .refreshable {
                await viewModel.getMovies()
            }
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(
                    title: Text("Error loading movies"),
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
    SearchListView()
}
