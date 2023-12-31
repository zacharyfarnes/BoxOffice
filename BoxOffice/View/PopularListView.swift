//
//  PopularListView.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 26/12/2023.
//

import SwiftUI

struct PopularListView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.navPath) {
            List {
                ForEach(viewModel.movies) { movie in
                    NavigationLink(value: movie) {
                        MovieRowView(movie: movie)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Popular")
            .refreshable {
                await viewModel.getMovies()
            }
            .task {
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
    PopularListView()
}
