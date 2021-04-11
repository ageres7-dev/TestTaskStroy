//
//  SearchBar.swift
//  TestTaskStroy
//
//  Created by Сергей on 11.04.2021.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @State private var isSearching = false
    
    
    var body: some View {
        HStack {
            HStack {
                TextField("Search GIF", text: $text)
                    .padding(.horizontal, 24)
            }
            .padding(8)
            .background(Color(.systemGray5))
            .cornerRadius(16)
            .onTapGesture {
                isSearching = true
            }
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .padding(.horizontal, 8)
                    Spacer()
                    
                    if isSearching && !text.isEmpty {
                        Button(action: { text = "" }){
                            Image(systemName: "xmark.circle")
                                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 8))
                        }
                        .animation(.spring())
                    }
                }
                .foregroundColor(.gray)
            )
        }
    }
}


struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
            .preferredColorScheme(.dark)
    }
}
