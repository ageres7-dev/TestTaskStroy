//
//  SearchGifView.swift
//  TestTaskStroy
//
//  Created by Сергей on 10.04.2021.
//

import SwiftUI

struct SearchGifView: View {
    @State private var selectedGIF: GIFObject?
    @State private var searchText = ""
    @State private var GIFs: [GIFObject]?
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    SearchView(text: $searchText)
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
                        Text("Cancel")
                    }
//                    .padding(.leading)
                }
                .padding()
            }
        }
    }

struct SearchView: View {
    @Binding var text: String
    @State private var isSearching = false
    
    var body: some View {
        HStack {
            HStack {
                TextField("Search GIF", text: $text)
                    .padding(.leading, 24)
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(16)
//            .padding(.horizontal)
            .onTapGesture {
                isSearching = true
            }
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
//                        .padding(.horizontal)
                    Spacer()
                    
                    if isSearching {
                        Button(action: { text = "" }){
                            Image(systemName: "xmark.circle")
//                                .padding()
                        }
                        .animation(.spring())
                    }
                }
                .foregroundColor(.gray)
                .padding(.horizontal)
            )
        }
    }
}


//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView(searchText: .constant(""))
//            .preferredColorScheme(.dark)
//    }
}

struct SearchGifView_Previews: PreviewProvider {
    static var previews: some View {
        SearchGifView()
            .preferredColorScheme(.dark)
    }
}
