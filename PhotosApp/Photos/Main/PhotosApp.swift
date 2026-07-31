//
//  BreweryApp.swift
//  Brewery
//
//  Created by Balaji Udayakumar on 3/29/23.
//

import SwiftUI

@main
struct PhotosApp: App {

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
