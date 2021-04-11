//
//  SearchGifView.swift
//  TestTaskStroy
//
//  Created by Сергей on 10.04.2021.
//

import SwiftUI
import SDWebImageSwiftUI
struct SearchGifView: View {
    @State private var selectedGIF: GIFObject?
    @State private var searchText = ""
    @State private var GIFs: [GIFObject]?
    
    
    var body: some View {
            VStack {
                HStack {
                    SearchView(text: $searchText)
                    /*
                    Button("Search") {
                        let url = "\(URLS.shared.buildUrl(forTerm: searchText, offset: "0")!)"
                        print(url)
                        NetworkManager.shared.fetchObject(SearchEndpoint.self, from: url ) { response in
                            GIFs = response.data
                            print(GIFs)
                        }
                    }
                    */
                        .onChange(of: searchText) { text in
                            let url = "\(URLS.shared.buildUrl(forTerm: searchText, offset: "0")!)"
                            print(url)
                            NetworkManager.shared.fetchObject(SearchEndpoint.self, from: url ) { response in
                                GIFs = response.data
                                print(GIFs)
                            }
                        }
                    
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
                        Text("Cancel")
                    }
                    //                    .padding(.leading)
                }
                .padding()
                
                ScrollView {
                    LazyVStack {
                        ForEach(GIFs ?? [], id: \.self) { GIF in
                            Text(""
                            )
                            let url = URL(string: GIF.images?.fixedHeight?.url ?? "")
                            AnimatedImage(url: url)
                                .indicator(SDWebImageActivityIndicator.medium)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        
                    }
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
                                .padding()
//                                .frame(width: 36, height: 34)
                        }
                        .animation(.spring())
                    }
                }
                .foregroundColor(.gray)
                .padding(.leading)
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
