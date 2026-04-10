//
//  BookViewModel.swift
//  Lab 4
//
//  Created by zenanchang on 2/24/26.
//

import Foundation
import Combine

class BookViewModel : ObservableObject
{
    @Published var currentIndex : Int = 0
    @Published var books: [Book] = [
         Book(title: "The Swift Journey",
              author: "Zenan Chang",
              genre: "Education",
              price: 29.99),
         
         Book(title: "iOS Development Basics",
              author: "Apple Inc.",
              genre: "Technology",
              price: 39.99),
         
         Book(title: "Mystery of the Night",
              author: "John Smith",
              genre: "Fiction",
              price: 19.50),
         
         Book(title: "Business Strategy 101",
              author: "Michael Lee",
              genre: "Business",
              price: 24.75)
     ]
    
    func addBook(title: String, author : String, genre : String , price :Double)
    {
        let newBook = Book(title: title, author: author, genre: genre, price: price)
        books.append(newBook)
    }
    func deleteBook(title: String)
    {
        if let foundIndex = books.firstIndex(where: { book in
            book.title.lowercased().contains(title.lowercased())
        }) {
            books.remove(at: foundIndex)
        }
    }
    
    func searchBook(title: String) -> Int?
    {
        return books.firstIndex(where: { book in
            book.title.lowercased().contains(title.lowercased()) ||
            book.genre.lowercased().contains(title.lowercased())
        })
    }
    
    

}
