//
//  BookEditView2.swift
//  Bookwormv2
//
//  Created by Anthony Gibson on 31/12/2022.
//

import SwiftUI

struct BookEditView2: View {
   @Environment(\.managedObjectContext) private var viewContext
   
   @Binding var dismissView: Bool
   
   // The book to edit
   @ObservedObject var book: Book
   
   @State private var showingImagePicker = false
   @State private var inputImage: UIImage?
   
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
             Section(header: Text("The Review")) {
                BookRatingView(rating: $book.rating)
                TextEditor(text: $book.review)
             }
             Section(header: Text("Edit the saved image")) {
                ZStack {
                   Image(uiImage: (UIImage(data: book.imageData) ?? UIImage(named: "defaultWaterImage"))!)
                      .resizable()
                      .scaledToFit()
                      .opacity(0.5)
                   Text("Tap to Update image")
                      .font(.title)
                }
                .onTapGesture {
                   // select an image
                   showingImagePicker = true
                }
             }
          }
          .navigationTitle("Edit Book")
          .sheet(isPresented: $showingImagePicker) {
             ImagePicker(image: $inputImage)
          }
          .onChange(of: inputImage) { _ in loadImage() }
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
   
   func loadImage() {
      guard let inputImage = inputImage else { return }
      book.imageData = inputImage.jpegData(compressionQuality: 0.0)!
      //image = Image(uiImage: inputImage)
   }
   
}

struct BookEditView2_Previews: PreviewProvider {
    static var previews: some View {
       BookEditView2(dismissView: .constant(false), book: Book.example)
    }
}
