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
    @State private var offset = 1
    
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
                LazyVStack {
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
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}


extension SearchGifView {
    
    private var isLoadNextPage: Bool {
        guard let totalCount = pagination?.totalCount,
              let count = pagination?.count,
              let currentOffset = pagination?.offset else { return false }
        
        return (count * currentOffset) < totalCount
    }
    
    private func actionLoadPage() {
        guard isLoadNextPage else { return }
        offset += 1
        NetworkManager.shared.searchGIF(from: searchText, offset: offset) { searchResponce in
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
