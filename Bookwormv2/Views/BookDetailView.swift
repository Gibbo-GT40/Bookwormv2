//
//  DetailView.swift
//  Bookwormv2
//
//  Created by Anthony Gibson on 22/12/2022.
//

import SwiftUI

struct BookDetailView: View {
   @Environment(\.managedObjectContext) private var viewContext
   @Environment(\.dismiss) var dismiss
   
   @State private var showDeleteAlert = false
   @State private var showEditSheet = false
   
   // The movie whose details we are viewing
   @ObservedObject var book: Book
   
   var body: some View {
      ScrollView {
         ZStack (alignment: .bottomTrailing) {
            Image(book.genre)
               .resizable()
               .scaledToFit()
            
            Text(book.genre.uppercased())
               .font(.caption)
               .fontWeight(.black)
               .padding(8)
               .foregroundColor(.white)
               .background(.black.opacity(0.75))
               .clipShape(Capsule())
               .offset(x: -5, y: -5)
         }
         Text(book.author)
            .font(.title)
            .foregroundColor(.secondary)
         Text(book.review)
            .padding()
         BookRatingView(rating: .constant(book.rating))
            .font(.largeTitle)
         Image(uiImage: (UIImage(data: book.imageData) ?? UIImage(named: "defaultWaterImage"))!)
            .resizable()
            .scaledToFit()
      }
      .navigationTitle(book.title)
      //.navigationBarTitleDisplayMode(.inline)
      .alert("Delete book?", isPresented: $showDeleteAlert) {
         Button("Delete", role: .destructive, action: deleteBook)
         Button("Cancel", role: .cancel) { }
      } message: {
         Text("Are you sure?")
      }
      .toolbar {
         Button {
            showDeleteAlert = true
         } label: {
            Label("Delete this book", systemImage: "trash")
         }
      }
      .toolbar {
         Button(action: {
            showEditSheet = true
         }) {
            Text("Edit")
         }
      }
      .sheet(isPresented: $showEditSheet) {
         NavigationView {
            BookEditView2(dismissView: $showEditSheet, book: book)
         }
      }
   }
   
   func deleteBook() {
      viewContext.delete(book)
      
      //try? moc.save()
      dismiss()
   }
}


struct BookDetailView_Previews: PreviewProvider {
   
   static var previews: some View {
      NavigationView {
         BookDetailView(book: Book.example)
      }
      .environmentObject(PersistenceController.preview)
   }
   
}
