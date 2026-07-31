//
//  PersistenceTest.swift
//  BudgetlyProjectTests
//
//  Created by Software Merchant on 8/15/22.
//

import CoreData

struct PersistenceTestController{
    
    static let shared = PersistenceTestController()
    let container: NSPersistentContainer

    init(inMemory: Bool = true) {
        container = NSPersistentContainer(name: "BudgetlyProject")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}
