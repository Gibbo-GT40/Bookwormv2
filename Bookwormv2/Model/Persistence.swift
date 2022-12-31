//
//  Persistence.swift
//  Bookwormv2
//
//  Created by Anthony Gibson on 22/12/2022.
//

import CoreData
import SwiftUI

class PersistenceController: ObservableObject {
   static let shared = PersistenceController()
   
   // for local CoreData only
   //let container: NSPersistentContainer
   
   // for CloudKit Coredata sync
   let container: NSPersistentCloudKitContainer
   
   static var preview: PersistenceController = {
      let result = PersistenceController(inMemory: true)
      let viewContext = result.container.viewContext
      let inputImage: UIImage = UIImage(named: "defaultWaterImage")!
      
      // Preview content for Book
      let book1 = Book(context: viewContext)
      book1.id = UUID()
      book1.title = "Test book1"
      book1.author = "Test author1"
      book1.genre = "Fantasy"
      book1.rating = 4
      book1.review = "This was a great book; I really enjoyed it."
      book1.imageData = inputImage.jpegData(compressionQuality: 0.0)!
      
      try? viewContext.save()
      
      let book2 = Book(context: viewContext)
      book2.title = "Test book2"
      book2.author = "Test author2"
      book2.genre = "Kids"
      book2.rating = 2
      book2.review = "Didnt like this one"
      book2.imageData = inputImage.jpegData(compressionQuality: 0.0)!
      
      try? viewContext.save()
      
      
      // Preview content for Item
      for _ in 0..<5 {
         let newItem = Item(context: viewContext)
         newItem.timestamp = Date()
      }
      do {
         try viewContext.save()
      } catch {
         // Replace this implementation with code to handle the error appropriately.
         // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         let nsError = error as NSError
         fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
      return result
   }()
   
   init(inMemory: Bool = false) {
      container = NSPersistentCloudKitContainer(name: "Bookwormv2")
      if inMemory {
         container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
      }
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
         if let error = error as NSError? {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            
            /*
             Typical reasons for an error here include:
             * The parent directory does not exist, cannot be created, or disallows writing.
             * The persistent store is not accessible, due to permissions or data protection when the device is locked.
             * The device is out of space.
             * The store could not be migrated to the current model version.
             Check the error message to determine what the actual problem was.
             */
            fatalError("Unresolved error \(error), \(error.userInfo)")
         }
      })
      container.viewContext.automaticallyMergesChangesFromParent = true
   }
}
