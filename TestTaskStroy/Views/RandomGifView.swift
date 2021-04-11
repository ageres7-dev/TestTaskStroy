//
//  RandomGifView.swift
//  TestTaskStroy
//
//  Created by Сергей on 10.04.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct RandomGifView: View {
    @State private var isFirsAppear = true
    @State private var gifData: GIFObject?
    @State private var showingSearch = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    
                    AnimatedImage(url: URL(string: gifData?.images?.fixedHeight?.url ?? ""))
                        .indicator(SDWebImageActivityIndicator.medium)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding()
                    
                    Button(action: fethRandomGif) {
                        Text("Load random GIF")
                            .setCustomStyleButton()
                    }
                    .padding()
                }
            }
            .onAppear() {
                if isFirsAppear {
                    fethRandomGif()
                    isFirsAppear = false
                }
            }
            .navigationTitle(gifData?.title ?? "Random GIF")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingSearch.toggle() }) {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingSearch) {
                SearchGifView(selectedGIF: $gifData)
            }
        }
    }
}

extension RandomGifView {
    private func fethRandomGif() {
        
        NetworkManager.shared.randomGIF { GIFObject in
            gifData = GIFObject
        }
    }
}




struct RandomGifView_Previews: PreviewProvider {
    static var previews: some View {
        RandomGifView()
    }
}
