//
//  LibraryViewModel.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 18/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation
import RxSwift

protocol BookSelectionDelegate: class {
    func didSelectBookAt(_ indexPath: IndexPath)
}

final class LibraryViewModel: CollectionViewModel {
    internal var model: [BookViewModel] {
        didSet { needsCollectionViewReloadSubject.onNext(()) }
    }
    
    private let libraryBusinessService: LibraryBusinessService
    private weak var routingDelegate: LibraryRoutingDelegate?
    
    // MARK: Collection View Management
    private var needsCollectionViewReloadSubject = PublishSubject<Void>()
    public var needsCollectionViewReloadObs: Observable<Void> {
        return needsCollectionViewReloadSubject.asObservable()
    }
    
    // MARK: Error Management
    private var needsDisplayErrorSubject = PublishSubject<LibraryError>()
    public var needsDisplayErrorObs: Observable<String> {
        return needsDisplayErrorSubject.asObservable().map { $0.description }
    }
    
    // MARK: Book Selection Counter
    private var booksSelectionCounter: Int = 0 {
        didSet { booksSelectionCounterSubject.onNext(booksSelectionCounter) }
    }
    private var booksSelectionCounterSubject: BehaviorSubject<Int>
    
    // MARK: Book Selection
    private var booksSelection: [BookViewModel] = [] {
        didSet { booksSelectionCounter = booksSelection.count }
    }
    
    init(businessService: LibraryBusinessService, routingDelegate: LibraryRoutingDelegate) {
        self.model = []
        self.routingDelegate = routingDelegate
        self.libraryBusinessService = businessService
        self.booksSelectionCounterSubject = BehaviorSubject<Int>(value: booksSelectionCounter)
        
        fetchBooks()
    }
    
    private func fetchBooks() {
        libraryBusinessService.fetchBooks { [weak self] (result: Result<[Book], LibraryError>) in
            switch result {
            case .success(let books):
                self?.model = books.map(BookViewModel.init)
                break
                
            case .failure(let libraryError):
                self?.needsDisplayErrorSubject.onNext(libraryError)
                break
            }
        }
    }
    
    private func addBookToSelectionAt(_ indexPath: IndexPath) {
        let selectedBookViewModel = elementAt(indexPath)
        booksSelection.append(selectedBookViewModel)
    }
}

// MARK: - Cart Button View Delegate
extension LibraryViewModel: CartButtonViewDelegate {
    
    var booksCounterObs: Observable<Int> {
        booksSelectionCounterSubject.asObservable()
    }
    
    func cartButtonTouched() {
        routingDelegate?.showOrderRecap(for: booksSelection)
    }
}

// MARK: - Book Selection Delegate
extension LibraryViewModel: BookSelectionDelegate {
    
    func didSelectBookAt(_ indexPath: IndexPath) {
        addBookToSelectionAt(indexPath)
    }
}
