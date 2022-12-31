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
   
   @State private var showingImagePicker = false
   @State private var inputImage: UIImage?
   
   @State private var title = ""
   @State private var author = ""
   @State private var genre: String = Genre.mystery.rawValue
   @State private var rating: Int16 = 3
   @State private var review = ""
   @State private var image: Image = Image("defaultWaterImage")
   
   //let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
   
   var body: some View {
      NavigationView {
         Form {
            Section {
               ZStack {
                  Rectangle()
                     .fill(.secondary)
                  image
                     .resizable()
                     .scaledToFit()
                  Text("Tap to select a picture")
                     .foregroundColor(.white)
                     .font(.headline)
                  
               }
               .onTapGesture {
                  // select an image
                  showingImagePicker = true
               }
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
         .onChange(of: inputImage) { _ in loadImage() }
         .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
         }
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
                  newBook.imageData = (inputImage?.jpegData(compressionQuality: 0.0))!
                  
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
   
   func loadImage() {
      guard let inputImage = inputImage else { return }
      image = Image(uiImage: inputImage)
   }
   
}


struct BookAddView_Previews: PreviewProvider {
   static var previews: some View {
      BookAddView()
   }
}
