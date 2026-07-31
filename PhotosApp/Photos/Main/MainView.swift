//
//  MainView.swift
//  Photos
//
//  Created by Software Merchant on 4/23/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            SearchView()
                .tabItem({ Label("", systemImage: "magnifyingglass") })
            FavouritesView()
                .tabItem({ Label("", systemImage: "heart") })
        }
    }
}
