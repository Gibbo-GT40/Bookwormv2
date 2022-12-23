//
//  BookEditView.swift
//  Bookwormv2
//
//  Created by Anthony Gibson on 22/12/2022.
//

import SwiftUI

struct BookEditView: View {
   @Environment(\.managedObjectContext) private var viewContext
   
   // Whether this view should be showing or not
   @Binding var dismissView: Bool
   
   // The book to edit
   @ObservedObject var book: Book
   
   var body: some View {
      NavigationView {
         Form {
            Section {
               TextField("", text: $book.title ?? "no title")
               TextField("", text: $book.author ?? "no author")
               Picker("Genre", selection: $book.genre) {
                  ForEach(Helper.genres, id: \.self) {
                     Text($0)
                  }
               }
            }
            Section {
               TextEditor(text: $book.review ?? "no Review")
               let ratingInt: Int = Int($book.rating)
               BookRatingView(rating: ratingInt)
            }
         }
      }
   }
   
//   func updateBook(book: Book) {
//      viewContext.performAndWait {
//         try? viewContext.save()
//      }
//   }
}


struct BookEditView_Previews: PreviewProvider {
   static var previews: some View {
      NavigationView {
         BookEditView(dismissView: .constant(false),
                      book: Book.example)
      }
      .environmentObject(PersistenceController.preview)
   }
}
