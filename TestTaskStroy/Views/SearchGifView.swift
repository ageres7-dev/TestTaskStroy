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
    @State private var pagination: PaginationObject?
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                SearchBar(text: $searchText)
                    .onChange(of: searchText) { text in
                        if searchText == "" {
                            GIFs = []
                        }
                        NetworkManager.shared.searchGIF(from: text, offset: offset) { searchResponce in
                            GIFs = searchResponce?.data ?? []
                            pagination = searchResponce?.pagination
                        }
                    }
                
                Button(action: { presentationMode.wrappedValue.dismiss() }){
                    Text("Cancel")
                }
            }
            .padding()
            
            Divider()
            
            ScrollView {
                LazyVGrid(columns: columns){
                    ForEach(GIFs.indices, id: \.self) { indexGIF in
                        let GIF = GIFs[indexGIF]
                        
                        let url = URL(string: GIF.images?.fixedHeightDownsampled?.url ?? "")
                        Button {
                            selectedGIF = GIF
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            AnimatedImage(url: url)
                                .indicator(SDWebImageActivityIndicator.medium)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .frame(width: 150, height: 150)
                                .padding()
                        }
                        .onAppear {
                            if indexGIF == GIFs.count - 2 {
                                actionLoadPage()
                            }
                        }
                    }
                }
                .padding(0)
            }
            .padding(0)
        }
        .onAppear{
            NetworkManager.shared.trandingGIFs { response in
                GIFs = response?.data ?? []
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}


extension SearchGifView {
    
    private var offset: Int {
        pagination?.offset ?? 1
    }
    
    private var columns: [GridItem] {
        [ GridItem(.adaptive(minimum: 150)) ]
    }
    
    private var isLoadNextPage: Bool {
        guard let totalCount = pagination?.totalCount,
              let count = pagination?.count,
              let currentOffset = pagination?.offset else { return false }
        
        return (count * currentOffset) < totalCount
    }
    
    private func actionLoadPage() {
        guard isLoadNextPage else { return }
        
        NetworkManager.shared.searchGIF(from: searchText, offset: offset + 1) { searchResponce in
            let newElemets = searchResponce?.data ?? []
            GIFs.append(contentsOf: newElemets)
            
            pagination = searchResponce?.pagination
        }
    }
}


struct SearchGifView_Previews: PreviewProvider {
    static var previews: some View {
        SearchGifView(selectedGIF: .constant(nil))
            .preferredColorScheme(.dark)
    }
}
