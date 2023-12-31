//
//  ActorsView.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 26/12/2023.
//

import SwiftUI

struct ActorListView: View {
    @StateObject private var viewModel: ViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(viewModel.actors) { actor in
                    ActorRowView(actor: actor)
                }
            }
            .padding([.leading, .bottom])
        }
        .task {
            await viewModel.getActors()
        }
        .alert(isPresented: $viewModel.showingAlert) {
            Alert(
                title: Text("Error loading actors"),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    init(movie: Movie) {
        let viewModel = ViewModel(movie: movie)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}

#Preview {
    ActorListView(movie: .example)
}
