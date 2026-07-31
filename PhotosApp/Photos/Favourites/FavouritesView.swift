//
//  FavouritesView.swift
//  Photos
//
//  Created by Software Merchant on 4/23/23.
//


import SwiftUI

struct FavouritesView: View {

    @FetchRequest(sortDescriptors: []) var images: FetchedResults<SavedImage>

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]){
                    ForEach(images, id:\.url) { image in
                        if let url = image.url {
                            FavoritesImageView(imageLink: url)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Favourites")
        }
    }
}
