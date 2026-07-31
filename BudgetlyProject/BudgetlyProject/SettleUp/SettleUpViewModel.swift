//
//  SettleUpViewModel.swift
//  BudgetlyProject
//
//  Created by Software Merchant on 8/12/22.
//

import Foundation

class SettleUpViewModel : ObservableObject{
    
    let currentTrip : Trips
    var finalSettlements = [String : [String : [Double]]]()
    
    @Published var mailData = MailData(subject: "", recipients: nil, message: "")
    @Published var showMailView = false
    
    init(currentTrip : Trips){
        self.currentTrip = currentTrip
        performCalculations()
        composeMail()
    }
    
    func performCalculations(){
        
        for item in 0 ..< currentTrip.peopleArray.count{
            var dictionary = [String : [Double]]()
            for expense in currentTrip.expensesArray{
                let splitArray = expense.split?.components(separatedBy: ";")
                if expense.paidBy != currentTrip.peopleArray[item]{
                    if dictionary[expense.paidBy!.wrappedName] != nil{
                        dictionary[expense.paidBy!.wrappedName]?.append(Double(splitArray![item])!)
                    }
                    else{
                        dictionary[expense.paidBy!.wrappedName] = [Double(splitArray![item])!]
                    }
                }
            }
            finalSettlements[currentTrip.peopleArray[item].wrappedName] = dictionary
        }
    }
    
    func composeMail(){
        
        var recipients  = [String]()
        for person in currentTrip.peopleArray{
            recipients.append(person.wrappedEmail)
        }
        var message = "\(newLine) \(tripNameText) \(currentTrip.wrappedName) \(newLine)\(newLine)"
        for (key, value) in  finalSettlements{
            message += "\(key) \(collon) \(newLine)"
            if value.isEmpty{
                message += "\(owesNothingText) \(newLine)"
            }
            else{
                for (key1, value1) in value{
                    message += "\(owes) \(key1) \(value1.reduce(0, +))\(dollar) \(newLine)"
                }
            }
        
        }
        mailData = MailData(subject: mailSubject, recipients: recipients, message: message)
    }
}
