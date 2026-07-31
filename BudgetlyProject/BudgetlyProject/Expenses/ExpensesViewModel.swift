//
//  ExpensesViewModel.swift
//  BudgetlyProject
//
//  Created by Balaji Udayakumar on 8/11/22.
//

import Foundation
import Combine

class ExpensesViewModel : ObservableObject{
    
    @Published var expenses : [Expenses] = []
    private var cancellable : AnyCancellable?
    
    var expensesPublisher : AnyPublisher<[Expenses], Never> = ExpensesStorage.shared.expenses.eraseToAnyPublisher()
    
    init(){
        cancellable = expensesPublisher.sink{ expenses in self.expenses = expenses }
        expenses.sort {$0.date! > $1.date!}
        
    }
    
}
