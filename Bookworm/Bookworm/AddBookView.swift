//
//  AddBookView.swift
//  Bookworm
//
//  Created by Helen Dempsey on 5/4/25.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    let date = Date.now
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section("Write a review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }

                Section {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, date: date)
                        modelContext.insert(newBook)
                        
                        dismiss()
                    }
                    .disabled(hasValidEntry == false)
                }
            }
            .navigationTitle("Add Book")
        }
    }
    
    var hasValidEntry: Bool {
        [title, author, review].contains(where: { $0.trimmingCharacters(in: .whitespaces).isEmpty }) == false
    }
}

#Preview {
    AddBookView()
}
