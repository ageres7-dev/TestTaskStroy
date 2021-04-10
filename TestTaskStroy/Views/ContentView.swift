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
                    Label("Случайная Gif", systemImage: "cube")
                }
            
            SearchGifView()
                .tabItem {
                    Label("Поиск", systemImage: "magnifyingglass.circle")
                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
