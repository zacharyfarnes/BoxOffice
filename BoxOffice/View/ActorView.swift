//
//  ActorView.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 26/12/2023.
//

import SwiftUI

struct ActorView: View {
    let actor: Actor
    
    var body: some View {
        VStack {
            AsyncImage(url: actor.profileURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Image(systemName: "camera")
            }
            .frame(height: 125)
            
            Text(actor.name)
                .bold()
                .lineLimit(1)
            Text(actor.character)
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
        .frame(width: 125)
    }
}

#Preview {
    ActorView(actor: .example)
}
