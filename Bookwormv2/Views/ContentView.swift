//
//  ContentView.swift
//  Bookwormv2
//
//  Created by Anthony Gibson on 22/12/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
   @Environment(\.managedObjectContext) private var viewContext
   
   @State private var showingAddScreen = false
   
   
   
   // Fetch Items from CoreData
   @FetchRequest(
      sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
      animation: .default)
   private var items: FetchedResults<Item>
   
   // Fetch Books from CoreData
   @FetchRequest(sortDescriptors: [
      SortDescriptor(\.title),
      SortDescriptor(\.author)
   ]) var books: FetchedResults<Book>
   
   var body: some View {
      NavigationView {
         List {
            ForEach(books) { book in
               NavigationLink {
                  BookDetailView(book: book)
               } label: {
                  HStack {
                     EmojiRatingView(rating: book.rating)
                        .font(.largeTitle)
                     
                     VStack(alignment: .leading) {
                        Text(book.title ?? "Unknown Title")
                           .font(.headline)
                        Text(book.author ?? "Unknown Author")
                           .foregroundColor(.secondary)
                     }
                  }
               }
            }
            .onDelete(perform: deleteBooks)
         }
         .navigationTitle("My Book List")
         .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
               EditButton()
            }
            ToolbarItem {
               Button {
                  showingAddScreen.toggle()
               } label: {
                  Label("Add Book", systemImage: "plus")
               }
            }
         }
         .sheet(isPresented: $showingAddScreen) {
            BookAddView()
         }
      }
   }
   
   private func addItem() {
      withAnimation {
         let newItem = Item(context: viewContext)
         newItem.timestamp = Date()
         
         do {
            try viewContext.save()
         } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
         }
      }
   }

   private func deleteBooks(offsets: IndexSet) {
      withAnimation {
         offsets.map { books[$0] }.forEach(viewContext.delete)
         
         do {
            try viewContext.save()
         } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
         }
      }
   }
}

private let itemFormatter: DateFormatter = {
   let formatter = DateFormatter()
   formatter.dateStyle = .short
   formatter.timeStyle = .medium
   return formatter
}()

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
   }
}
