//
//  BookViewModelTests.swift
//  HenriPotierLibraryTests
//
//  Created by Mathis Detourbet on 24/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import XCTest
@testable import HenriPotierLibrary

class BookViewModelTests: XCTestCase {
    
    private var bookViewModel: BookViewModel!
    private let bookModel = DataFactory.makeBook()

    override func setUp() {
        bookViewModel = BookViewModel(book: bookModel)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_BookIdentifier_Should_Display_Book_ISBN() {
        XCTAssert(bookViewModel.bookIdentifier == bookModel.isbn, "Book identifier should be equal to the book isbn")
    }
    
    func test_BookPrice_Should_Display_Book_Price() {
        XCTAssert(bookViewModel.bookPrice == bookModel.price, "Book price should be equal to the book price in book model")
    }
}
