//
//  PeopleStorage.swift
//  BudgetlyProject
//
//  Created by Software Merchant on 8/10/22.
//

import Foundation
import CoreData
import Combine

class PeopleStorage : NSObject, ObservableObject{
    
    var people = CurrentValueSubject<[People], Never>([])
    private let peopleFetchController : NSFetchedResultsController<People>
    let viewContext = PersistenceController.shared.container.viewContext
    
    static let shared : PeopleStorage = PeopleStorage()
    
    private override init() {
        
        let fetchRequest: NSFetchRequest<People> = People.fetchRequest()
        fetchRequest.sortDescriptors = []
        peopleFetchController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        
        peopleFetchController.delegate = self
        
        do{
            try peopleFetchController.performFetch()
            people.value = peopleFetchController.fetchedObjects ?? []
        }
        catch{
            NSLog("Error : Could Not Fetch Objects")
        }
    }
}

extension PeopleStorage : NSFetchedResultsControllerDelegate{
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let people = controller.fetchedObjects as? [People] else { return }
        self.people.value = people
    }
}

