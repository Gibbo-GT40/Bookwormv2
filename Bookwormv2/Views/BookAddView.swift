//
//  BookAddView.swift
//  Bookwormv2
//
//  Created by Anthony Gibson on 22/12/2022.
//

import SwiftUI

struct BookAddView: View {
   @Environment(\.managedObjectContext) private var viewContext
   @Environment(\.dismiss) var dismiss
   
   @State private var title = ""
   @State private var author = ""
   @State private var genre: String = Genre.mystery.rawValue
   @State private var rating: Int16 = 3
   @State private var review = ""
   
   //let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
   
   var body: some View {
      NavigationView {
         Form {
            Section {
               TextField("Name of book", text: $title)
               TextField("Author's name", text: $author)
               Picker("Genre", selection: $genre) {
                  ForEach(Genre.allCases, id: \.self) { value in
                     Text(String(value.rawValue))
                        .tag(value.rawValue)
                  }
               }
            }
            Section {
               BookRatingView(rating: $rating)
               TextEditor(text: $review)
            } header: {
               Text("Write a review")
            }
         }
         .navigationTitle("Add Book")
         .toolbar {
            ToolbarItem {
               Button("Save") {
                  let newBook = Book(context: viewContext)
                  newBook.id = UUID()
                  newBook.title = title
                  newBook.author = author
                  newBook.rating = rating
                  newBook.review = review
                  newBook.genre = genre
                  
                  try? viewContext.save()
                  dismiss()
               }
            }
            ToolbarItem(placement: .navigationBarLeading) {
               Button("Cancel") {
                  dismiss()
               }
            }
         }
      }
   }
}


struct BookAddView_Previews: PreviewProvider {
   static var previews: some View {
      BookAddView()
   }
}
