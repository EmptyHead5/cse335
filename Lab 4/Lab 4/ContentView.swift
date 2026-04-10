//
//  ContentView.swift
//  Lab 4
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = BookViewModel()
    @State private var currentIndex: Int = 0
    @State private var showingSearchSheet = false
    @State private var bookTitle = ""
    
    @State private var showAlert = false
    @State private var alertMessage = ""

    @State private var showBookOrderAlert = false
    @State private var showAddBook = false
    
    @State private var showDeleteBook = false
    @State private var deletedBook = ""

    @State private var newBookAuthor = ""
    @State private var newBookGenre = ""
    @State private var newBookPrice = ""
    @State private var newBookTitle = ""

    @State private var searchedBookTitle = "N/A"
    @State private var seacrhedBookAuthor = "N/A"
    @State private var seacrhedBookGenre = "N/A"
    @State private var seacrhedBookPrice = "N/A"

    var body: some View {

        NavigationStack {

            ZStack {
                if viewModel.books.isEmpty {

                    VStack {
                        Spacer()
                        
                        Text("Preview Unavailable\nPlease add your first book")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)

                        Spacer()
                    }

                } else {

                    VStack(spacing: 30) {

                        VStack(spacing: 15) {
                            Text(viewModel.books[currentIndex].title)
                                .font(.title)
                                .bold()

                            Text("Author: \(viewModel.books[currentIndex].author)")
                            Text("Genre: \(viewModel.books[currentIndex].genre)")
                            Text(String(format: "Price: $%.2f",
                                        viewModel.books[currentIndex].price))
                        }
                        .padding()

                        Spacer()
                    }
                    .toolbar {
                        ToolbarItem(placement: .bottomBar)
                                {
                            HStack(spacing: 10) {
                                Button {
                                    showAddBook = true
                                } label: {
                                    Image(systemName: "folder.badge.plus")
                                        .foregroundColor(.blue)
                                }
                                
                                Button {
                                        showDeleteBook = true
                                    } label: {
                                    Image(systemName: "folder.badge.minus")
                                            .foregroundColor(.blue)
                                }
                                Spacer()
                                Button("Previous") {
                                    if currentIndex > 0 {
                                        currentIndex -= 1
                                    } else {
                                        alertMessage = "This is the first book."
                                        showBookOrderAlert = true
                                    }
                                }

                                Button("Next") {
                                    if currentIndex < viewModel.books.count - 1 {
                                        currentIndex += 1
                                    } else {
                                        alertMessage = "This is the last book."
                                        showBookOrderAlert = true
                                    }
                                }

                            }
                        }
                    }
                }
            }
            .navigationTitle("Book List")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button {
                        showingSearchSheet = true
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
        }

        .alert("Opps..", isPresented: $showBookOrderAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
        .sheet(isPresented: $showDeleteBook) {
            NavigationStack {
                Form{
                    TextField("Please enter the title or genre of the book you want to delete.", text: $deletedBook)
                        .textFieldStyle(.roundedBorder)
                }
                .navigationTitle("Delete Book")
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Button {
                            viewModel.deleteBook(title: deletedBook)
                            showDeleteBook = false
                        } label: {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showAddBook) {
            NavigationStack {
                Form {
                    TextField("Enter book title", text: $newBookTitle)
                    TextField("Enter book author", text: $newBookAuthor)
                    TextField("Enter book genre", text: $newBookGenre)
                    TextField("Enter book price", text: $newBookPrice)
                }
                .navigationTitle("Add Book")
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Button {
                            if let bookprice = Double(newBookPrice)
                            {
                                viewModel.addBook(title: newBookTitle, author: newBookAuthor, genre: newBookGenre, price: bookprice)
                                showAddBook = false
                            }else {
                                alertMessage = "Price must be a valid number."
                                showAlert = true
                            }
                        } label: {
                            Image(systemName: "checkmark")
                        }
                    }
                }
                .alert("Invalid Input", isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(alertMessage)
                }
            }
        }
        .sheet(isPresented: $showingSearchSheet) {
            NavigationStack {
                Form {
                    TextField("Type your Book Title", text: $bookTitle)

                    Button("Search") {
                        if let foundIndex = viewModel.searchBook(title: bookTitle){
                            currentIndex = foundIndex
                            searchedBookTitle = viewModel.books[currentIndex].title
                            seacrhedBookAuthor = viewModel.books[currentIndex].author
                            seacrhedBookGenre = viewModel.books[currentIndex].genre
                            seacrhedBookPrice = String(viewModel.books[currentIndex].price)
                            showAlert = true
                        }
                    }

                    Section(header: Text("SEARCH RESULT")) {
                        TextField("Title", text: $searchedBookTitle)
                        TextField("Author", text: $seacrhedBookAuthor)
                        TextField("Genre", text: $seacrhedBookGenre)
                        TextField("Price", text: $seacrhedBookPrice)
                    }

                    Button("Update Book") {
                        viewModel.books[currentIndex].title = searchedBookTitle
                        viewModel.books[currentIndex].author = seacrhedBookAuthor
                        viewModel.books[currentIndex].genre = seacrhedBookGenre

                        if let newPrice = Double(seacrhedBookPrice) {
                            viewModel.books[currentIndex].price = newPrice
                        }

                        showingSearchSheet = false
                    }
                }
                .navigationTitle("Search Book")
                .alert("Message", isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("WE found the Book!\n You may edit the book now!")
                }
            }
        }
    }
}


#Preview {
    ContentView()
}


