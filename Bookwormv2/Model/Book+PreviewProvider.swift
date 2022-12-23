//
//  Book+PreviewProvider.swift
//  Bookwormv2
//
//  Created by Anthony Gibson on 22/12/2022.
//

import Foundation
import CoreData

// Exists to provide a book to use with BookDetailView and BookEditView
extension Book {
   
   // Example movie for Xcode previews
   static var example: Book {
      
      // Get the first movie from the in-memory Core Data store
      let context = PersistenceController.preview.container.viewContext
      
      let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
      fetchRequest.fetchLimit = 1
      
      let results = try? context.fetch(fetchRequest)
      
      return (results?.first!)!
   }
   
}

