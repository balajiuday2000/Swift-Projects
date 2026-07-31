//
//  TripsStorage.swift
//  BudgetlyProject
//
//  Created by Software Merchant on 8/10/22.
//

import Foundation
import CoreData
import Combine

class TripsStorage : NSObject, ObservableObject{
    
    var trips = CurrentValueSubject<[Trips], Never>([])
    private let tripsFetchController : NSFetchedResultsController<Trips>
    let viewContext = PersistenceController.shared.container.viewContext
    
    static let shared : TripsStorage = TripsStorage()
    
    private override init() {
        
        let fetchRequest: NSFetchRequest<Trips> = Trips.fetchRequest()
        fetchRequest.sortDescriptors = []
        tripsFetchController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        
        tripsFetchController.delegate = self
        
        do{
            try tripsFetchController.performFetch()
            trips.value = tripsFetchController.fetchedObjects ?? []
        }
        catch{
            NSLog("Error : Could Not Fetch Objects")
        }
    }
    
    func add(tripName : String, tripDuration : String, peopleNames : [String], peopleEmails : [String]){
        
        let newTrip = Trips(context: viewContext)
        newTrip.name = tripName
        newTrip.duration = tripDuration
        
        var peopleArray = [People]()
        
        for item in 0 ..< peopleNames.count{
            let person = People(context: viewContext)
            person.name = peopleNames[item]
            person.email = peopleEmails[item]
            peopleArray.append(person)
        }
        
        newTrip.addToHasPeople(NSSet(array: peopleArray))
        
        try? viewContext.save()
    }
    
    func addPeopleToTrip(currentTrip : Trips, peopleNames : [String], peopleEmails : [String]){
        
        var peopleArray = [People]()
        
        for item in 0 ..< peopleNames.count{
            let person = People(context: viewContext)
            person.name = peopleNames[item]
            person.email = peopleEmails[item]
            peopleArray.append(person)
        }
        
        currentTrip.addToHasPeople(NSSet(array: peopleArray))
        
        try? viewContext.save()
    }
}

extension TripsStorage : NSFetchedResultsControllerDelegate{
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let trips = controller.fetchedObjects as? [Trips] else { return }
        self.trips.value = trips
    }
}

