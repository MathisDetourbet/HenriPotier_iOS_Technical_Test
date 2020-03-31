//
//  DataFactory.swift
//  HenriPotierLibraryTests
//
//  Created by Mathis Detourbet on 24/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation
@testable import HenriPotierLibrary

class DataFactory {
    
    private static func loadBooksFromJSON() -> [Book] {
        let bundle = Bundle(for: self)
        guard let path = bundle.path(forResource: "fetchBooksJSON", ofType: "json") else {
            return []
        }
        
        let fileUrl = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: fileUrl)
            let jsonDecoder = JSONDecoder()
            let decodedObjects = try jsonDecoder.decode([Book].self, from: data)
            return decodedObjects
        } catch {
            return []
        }
    }
    
    static func makeBook() -> Book {
        return Book(isbn: "c8fabf68-8374-48fe-a7ea-a00ccd07afff",
                    title: "Henri Potier à l'école des sorciers",
                    price: 35,
                    cover: "http://henri-potier.xebia.fr/hp0.jpg")
    }
    
    static func makeBooksViewModel() -> [BookViewModel] {
        let books = loadBooksFromJSON()
        var bookViewModels: [BookViewModel] = []
        for book in books {
            bookViewModels.append(BookViewModel(book: book))
        }
        return bookViewModels
    }
}
