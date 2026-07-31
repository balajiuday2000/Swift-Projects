//
//  TripsViewModel.swift
//  BudgetlyProject
//
//  Created by Software Merchant on 8/10/22.
//

import Foundation
import Combine

class TripsViewModel : ObservableObject{
    
    @Published var trips : [Trips] = []
    private var cancellable : AnyCancellable?
    
    var tripsPublisher : AnyPublisher<[Trips], Never> = TripsStorage.shared.trips.eraseToAnyPublisher()
    
    init(){
        cancellable = tripsPublisher.sink{ trips in self.trips = trips }
    }
}


