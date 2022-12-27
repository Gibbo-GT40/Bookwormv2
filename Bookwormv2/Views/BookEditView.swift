//
//  BookEditView.swift
//  Bookwormv2
//
//  Created by Anthony Gibson on 22/12/2022.
//

import SwiftUI

struct BookEditView: View {
   @Environment(\.managedObjectContext) private var viewContext
   
   @Binding var dismissView: Bool
   
   // The book to edit
   @ObservedObject var book: Book
   
   var body: some View {
      NavigationView {
         Form {
            Section {
               TextField("", text: $book.title)
               TextField("", text: $book.author)
               Picker("Genre", selection: $book.genre) {
                  ForEach(Genre.allCases, id: \.self) { value in
                     Text(String(value.rawValue))
                        .tag(value.rawValue)
                  }
               }
            }
            Section {
               BookRatingView(rating: $book.rating)
               TextEditor(text: $book.review)
            }header: {
               Text("The Review")
            }
         }
         .navigationTitle("Edit Book")
         .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
               Button("Update") {
                  try? viewContext.save()
                  dismissView.toggle()
               }
            }
            ToolbarItem(placement: .navigationBarLeading) {
               Button("Cancel") {
                  dismissView.toggle()
               }
            }
         }
      }
   }
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
