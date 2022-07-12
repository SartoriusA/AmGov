//
//  amGov2022AppApp.swift
//  amGov2022App
//
//  Created by Andrew J. Sartorius on 6/23/22.
//

import SwiftUI

enum AppViews: Int{
    case home, game, leaderbaord, credits
}

class CurrentView: ObservableObject{
    @Published var currentView: AppViews = .home
}

@main
struct amGov2022AppApp: App {
    var currentView = CurrentView()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(currentView)
        }
    }
}
