//
//  Expenses+CoreDataProperties.swift
//  BudgetlyProject
//
//  Created by Software Merchant on 8/10/22.
//
//

import Foundation
import CoreData


extension Expenses {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expenses> {
        return NSFetchRequest<Expenses>(entityName: "Expenses")
    }

    @NSManaged public var amount: String?
    @NSManaged public var name: String?
    @NSManaged public var split: String?
    @NSManaged public var bill: Data?
    @NSManaged public var date: Date?
    @NSManaged public var belongsToTrip: Trips?
    @NSManaged public var paidBy: People?

}

extension Expenses : Identifiable {

}
