//
//  ActorsView.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 26/12/2023.
//

import SwiftUI

struct ActorListView: View {
    let movie: Movie
    @State private var actors = [Actor]()
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(actors) { actor in
                    ActorView(actor: actor)
                }
            }
            .padding([.leading, .bottom])
        }
        .task {
            await getActors()
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Error loading actors"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
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

#Preview {
    ActorListView(movie: .example)
}
