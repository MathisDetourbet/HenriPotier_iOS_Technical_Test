//
//  BookViewModel.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 19/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation
import RxSwift

final class BookViewModel: BookCellPresenter {
    private let book: Book
    
    public var bookIdentifier: String {
        return book.isbn
    }
    
    public var bookPrice: Double {
        return book.price
    }
    
    private var bookCoverUrlSubject: BehaviorSubject<URL?>
    public var bookCoverUrlObs: Observable<URL?> {
        return bookCoverUrlSubject.asObservable()
    }
    
    private var bookTitleSubject: BehaviorSubject<String>
    public var bookTitleObs: Observable<String> {
        return bookTitleSubject.asObservable()
    }
    
    private var bookPriceSubject: BehaviorSubject<String>
    public var bookPriceObs: Observable<String> {
        return bookPriceSubject.asObservable()
    }
    
    init(book: Book) {
        self.book = book
        self.bookCoverUrlSubject = BehaviorSubject<URL?>.init(value: URL(string: book.cover))
        self.bookTitleSubject = BehaviorSubject<String>(value: book.title)
        self.bookPriceSubject = BehaviorSubject<String>(value: String("\(book.price) €"))
    }
}
