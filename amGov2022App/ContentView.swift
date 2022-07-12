//
//  ContentView.swift
//  amGov2022App
//
//  Created by Andrew J. Sartorius on 6/23/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var cv: CurrentView
    var body: some View {
        switch cv.currentView{
        case .home:
            Home()
        case .game:
            Game()
        case .leaderbaord:
            LeaderBoard()
        case .credits:
            Credits()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
