//
//  FavoritesImageView.swift
//  Photos
//
//  Created by Software Merchant on 5/15/23.
//

import SwiftUI

struct FavoritesImageView: View {
    
    var imageLink: String
    @State private var isBlurred: Bool = false

    init(imageLink: String) {
        self.imageLink = imageLink
    }

    var body: some View {
        ZStack {
            ImageView(imageLink: self.imageLink)
                .blur(radius: isBlurred ? 5 : 0)
            if isBlurred {
                Button {
                    // Save image to gallery
                } label: {
                    Label("", systemImage: "square.and.arrow.down.fill")
                        .foregroundColor(.red)
                        .font(.system(size: 36))
                }
            }
        }
        .onLongPressGesture(minimumDuration: 1.0) {
            withAnimation {
                isBlurred.toggle()
            }
        }
    }
}

