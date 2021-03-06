//
//  ContentView.swift
//  TestTaskStroy
//
//  Created by Сергей on 08.04.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                ProfileView(
                    user: User.generateMe(),
                    frends: User.generateFrends()
                )
            }
            .tabItem {
                Label("Профиль", systemImage: "person.circle")
                
            }
            
            RandomGifView()
                .tabItem {
                    Label("GIPHY API", systemImage: "photo.on.rectangle.angled")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
