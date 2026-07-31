//
//  BudgetlyProjectApp.swift
//  BudgetlyProject
//
//  Created by Balaji Udayakumar on 8/10/22.
//

import SwiftUI

@main
struct BudgetlyProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
