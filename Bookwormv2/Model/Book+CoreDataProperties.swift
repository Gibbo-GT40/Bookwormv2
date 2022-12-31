//
//  Book+CoreDataProperties.swift
//  Bookwormv2
//
//  Created by Anthony Gibson on 23/12/2022.
//
//

import Foundation
import CoreData
import SwiftUI


extension Book: Identifiable{
   
   @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
      return NSFetchRequest<Book>(entityName: "Book")
   }
   
   @NSManaged public var author: String
   @NSManaged public var genre: String
   @NSManaged public var id: UUID?
   @NSManaged public var rating: Int16
   @NSManaged public var review: String
   @NSManaged public var title: String
   @NSManaged public var imageData: Data
   
}

enum Genre: String, Equatable, CaseIterable {
   case fantasy = "Fantasy"
   case horror = "Horror"
   case kids = "Kids"
   case mystery = "Mystery"
   case poetry = "Poetry"
   case romance = "Romance"
   case thriller = "Thriller"

}
