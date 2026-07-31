//
//  ExpensesInfoViewModel.swift
//  BudgetlyProject
//
//  Created by Balaji Udayakumar on 8/11/22.
//

import Foundation
import UIKit

class ExpensesInfoViewModel : ObservableObject{
    
    var currentExpense : Expenses
    var split : [String]
    var peopleInTrip : [People]
    var billImage : UIImage? = nil
    
    let dateFormatter = DateFormatter()
    init(currentExpense : Expenses){
        self.currentExpense = currentExpense
        self.split = (self.currentExpense.split?.components(separatedBy: ";"))!
        self.peopleInTrip = self.currentExpense.belongsToTrip!.peopleArray
        
        if let bill = self.currentExpense.bill{
            self.billImage = UIImage(data: bill)
        }
        
        dateFormatter.dateFormat = dateformat
    }
    
}
