//
//  ImageViewModel.swift
//  Photos
//
//  Created by Software Merchant on 4/23/23.
//

import Combine
import CoreData
import Foundation
import SwiftUI

class ImageViewModel: ObservableObject {

    @Published var hearted: Bool = false
    let imageLink: String
    let context = PersistenceController.shared.container.viewContext

    init(imageLink: String) {
        self.imageLink = imageLink
        self.hearted = isFavourite()
    }

    func heartTapped() {
        self.hearted.toggle()
        self.hearted ? addToFavourites() : removeFromFavourites()
    }

    private func isFavourite() -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedImage")
        fetchRequest.predicate = NSPredicate(format: "url == %@", self.imageLink)
        return ((try? context.count(for: fetchRequest)) ?? 0) > 0
    }

    private func addToFavourites() {
        let imageToBeSaved = SavedImage(context: context)
        imageToBeSaved.url = self.imageLink
        try? context.save()
    }

    private func removeFromFavourites() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedImage")
        fetchRequest.predicate = NSPredicate(format: "url == %@", self.imageLink)
        let object = try? context.fetch(fetchRequest).first as? NSManagedObject
        if let object {
            context.delete(object)
            try? context.save()
        }
    }
}
