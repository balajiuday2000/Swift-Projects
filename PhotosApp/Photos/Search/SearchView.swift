//
//  ContentView.swift
//  Brewery
//
//  Created by Balaji Udayakumar on 3/29/23.
//

import SwiftUI

struct SearchView: View {

    @ObservedObject var viewModel = SearchViewModel()
    @State private var reloadGrid = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("Type here", text: $viewModel.text)
                    .textFieldStyle(.roundedBorder)
                    .foregroundColor(.black)
                    .autocorrectionDisabled(true)
                Spacer(minLength: 20)
                if !viewModel.text.isEmpty && !viewModel.data.items.isEmpty {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]){
                            ForEach(viewModel.data.items, id:\.media.m) { image in
                                ImageView(imageLink: image.media.m)
                            }
                        }
                        .id(reloadGrid)
                    }
                }
            }
            .padding()
            .onAppear { reloadGrid.toggle() }
            .onChange(of: viewModel.text) { _ in viewModel.fetchData() }
            .navigationTitle("Search")
        }
    }
}
