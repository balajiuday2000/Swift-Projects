//
//  PeopleStorageTest.swift
//  BudgetlyProjectTests
//
//  Created by Balaji Udayakumar on 8/15/22.
//

import Foundation
import Combine
import CoreData
import BudgetlyProject

class PeopleStorageTest : NSObject, ObservableObject{
    
    var people = CurrentValueSubject<[People], Never>([])
    private let peopleFetchController : NSFetchedResultsController<People>
    let viewContext = PersistenceTestController.shared.container.viewContext
    
    static let shared : PeopleStorageTest = PeopleStorageTest()
    
    var entityDescription: NSEntityDescription!
    
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
        
        entityDescription  = NSEntityDescription.entity(forEntityName: "People", in: viewContext)!
    }
    
    func add(name : String, email : String){
        
        let newPerson = People(entity: entityDescription, insertInto: viewContext)
        newPerson.name = name
        newPerson.email = email
        try? viewContext.save()
    }
    
}

extension PeopleStorageTest : NSFetchedResultsControllerDelegate{
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let people = controller.fetchedObjects as? [People] else { return }
        self.people.value = people
    }
}
