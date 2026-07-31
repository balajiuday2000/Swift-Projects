//
//  DataManager.swift
//  Photos
//
//  Created by Balaji Udayakumar on 4/23/23.
//

import CoreData
import Foundation

struct PersistenceController {
    
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "SavedData")
        container.loadPersistentStores { _, _ in }
    }
}
