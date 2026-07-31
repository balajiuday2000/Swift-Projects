//
//  ImageView.swift
//  Brewery
//
//  Created by Balaji Udayakumar on 3/30/23.
//

import Combine
import SwiftUI

struct ImageView: View {

    var imageLink: String
    @ObservedObject var viewModel: ImageViewModel
    @State private var isFlipped: Bool = false

    init(imageLink: String) {
        self.imageLink = imageLink
        self.viewModel = ImageViewModel(imageLink: imageLink)
    }

    var body: some View {
        AsyncImage(url: URL(string: imageLink)!) { data in
            data.resizable()
                .overlay(alignment: .topTrailing, content: {
                    Button {
                        viewModel.heartTapped()
                    } label: {
                        Label("", systemImage: "heart.fill")
                            .foregroundColor(viewModel.hearted ? .red : .white)
                            .frame(width: 30.0, height: 30.0)
                    }
                })
        } placeholder: {
            ProgressView()
                .frame(height: 120.0)
        }
    }
}
