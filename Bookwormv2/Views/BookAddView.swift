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
   @State private var genre = ""
   @State private var rating = 3
   @State private var review = ""
   
   //let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
   
    var body: some View {
       NavigationView {
          Form {
             Section {
                TextField("Name of book", text: $title)
                TextField("Author's name", text: $author)
                
                Picker("Genre", selection: $genre) {
                   ForEach(Helper.genres, id: \.self) {
                      Text($0)
                   }
                }
             }
             
             Section {
                TextEditor(text: $review)
                BookRatingView(rating: $rating)
             } header: {
                Text("Write a review")
             }
             
             Section {
                Button("Save") {
                  
                   try? viewContext.save()
                   dismiss()
                }
             }
          }
          .navigationTitle("Add Book")
       }
    }
}

struct BookAddView_Previews: PreviewProvider {
    static var previews: some View {
        BookAddView()
    }
}
