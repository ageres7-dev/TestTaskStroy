//
//  SearchGifView.swift
//  TestTaskStroy
//
//  Created by Сергей on 10.04.2021.
//

import SwiftUI
import SDWebImageSwiftUI
struct SearchGifView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedGIF: GIFObject?
    @State private var searchText = ""
    @State private var GIFs: [GIFObject] = []
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                SearchView(text: $searchText)
                    .onChange(of: searchText) { text in
                        if searchText == "" {
                            GIFs = []
                        }
                        NetworkManager.shared.searchGIF(from: text, offset: 0) { GIFs in
                            self.GIFs = GIFs
                        }
                    }
                
                Button(action: { presentationMode.wrappedValue.dismiss() }){
                    Text("Cancel")
                }
            }
            .padding()
            
            Divider()
            
            ScrollView {
                LazyVStack {
                    ForEach(GIFs, id: \.self) { GIF in
                        
                        let url = URL(string: GIF.images?.fixedHeight?.url ?? "")
                        Button {
                            selectedGIF = GIF
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            AnimatedImage(url: url)
                                .indicator(SDWebImageActivityIndicator.medium)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .padding()
                        }
                    }
                }
                .padding(0)
            }
            .padding(0)
            
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
                    .padding(.horizontal, 24)
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(16)
            .onTapGesture {
                isSearching = true
            }
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .padding(.horizontal)
                    Spacer()
                    
                    if isSearching && !text.isEmpty {
                        Button(action: { text = "" }){
                            Image(systemName: "xmark.circle")
                                .padding()
                        }
                        .animation(.spring())
                    }
                }
                .foregroundColor(.gray)
            )
        }
    }
}


//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView(searchText: .constant(""))
//            .preferredColorScheme(.dark)
//    }
//}

struct SearchGifView_Previews: PreviewProvider {
    static var previews: some View {
        SearchGifView(selectedGIF: .constant(nil))
            .preferredColorScheme(.dark)
    }
}
