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
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    AnimatedImage(url: URL(string: gifData?.images?.fixedHeight?.url ?? ""))
                        .indicator(SDWebImageActivityIndicator.medium)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                    Button(action: fethRandomGif) {
                        Text("Load random GIF")
                    }
                }
            }
            .onAppear() {
                if isFirsAppear {
                    fethRandomGif()
                    isFirsAppear = false
                }
            }
            .navigationTitle(gifData?.title ?? "Random GIF")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension RandomGifView {
    private func fethRandomGif() {
        NetworkManager.shared.fetchObject(RandomEndpoint.self,
                                          from: Constant.urlRandomGig.rawValue) { randomEndpoint in
            gifData = randomEndpoint.data
        }
    }
}




struct RandomGifView_Previews: PreviewProvider {
    static var previews: some View {
        RandomGifView()
    }
}
