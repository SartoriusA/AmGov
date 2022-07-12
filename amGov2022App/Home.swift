//
//  Home.swift
//  amGov2022App
//
//  Created by Andrew J. Sartorius on 7/11/22.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var cv: CurrentView
    var body: some View {
        HStack{
            Spacer()
        VStack{
            Spacer()
            Text("American Government and Politics")
                .foregroundColor(.yellow)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
            Text("Triva Game")
                .font(.title)
                .foregroundColor(.yellow)
                .padding()
            Spacer()
            Button("Start") {
                cv.currentView = .game
            }
            .font(.largeTitle)
            .foregroundColor(.yellow)
            .padding()
            .background(.blue)
            Spacer()
        }

            Spacer()
        }
        .background(Color(white:0.1))
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
