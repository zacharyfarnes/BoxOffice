//
//  BoxOfficeApp.swift
//  BoxOffice
//
//  Created by Zachary Farnes on 26/12/2023.
//

import SwiftUI

@main
struct BoxOfficeApp: App {
    @StateObject var favorites = Favorites()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(favorites)
        }
    }
}
