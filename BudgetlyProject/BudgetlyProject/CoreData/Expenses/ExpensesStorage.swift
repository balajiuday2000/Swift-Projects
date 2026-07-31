//
//  ExpensesStorage.swift
//  BudgetlyProject
//
//  Created by Balaji Udayakumar on 8/11/22.
//

import Foundation
import CoreData
import Combine

class ExpensesStorage : NSObject, ObservableObject{
    
    var expenses = CurrentValueSubject<[Expenses], Never>([])
    private let expensesFetchController : NSFetchedResultsController<Expenses>
    let viewContext = PersistenceController.shared.container.viewContext
    
    static let shared : ExpensesStorage = ExpensesStorage()
    
    private override init() {
        
        let fetchRequest: NSFetchRequest<Expenses> = Expenses.fetchRequest()
        fetchRequest.sortDescriptors = []
        expensesFetchController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        
        expensesFetchController.delegate = self
        
        do{
            try expensesFetchController.performFetch()
            expenses.value = expensesFetchController.fetchedObjects ?? []
        }
        catch{
            NSLog("Error : Could Not Fetch Objects")
        }
    }
    
    func add(name : String, amount : String, paidBy : People, split : String, date : Date, bill : Data?, currentTrip : Trips){
        
        let newExpense = Expenses(context: viewContext)
        newExpense.name = name
        newExpense.amount = amount
        newExpense.paidBy = paidBy
        newExpense.split = split
        newExpense.date = date
        newExpense.bill = bill
        newExpense.belongsToTrip = currentTrip
        
        try? viewContext.save()
    }
}

extension ExpensesStorage : NSFetchedResultsControllerDelegate{
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let expenses = controller.fetchedObjects as? [Expenses] else { return }
        self.expenses.value = expenses
    }
}


