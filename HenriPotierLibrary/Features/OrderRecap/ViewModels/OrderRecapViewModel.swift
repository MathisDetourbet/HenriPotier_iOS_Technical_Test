//
//  OrderRecapViewModel.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 22/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation
import RxSwift

final class OrderRecapViewModel: CollectionViewModel {
    
    internal let model: [BookViewModel]
    private let orderRecapBusinessService: OrderRecapBusinessService
    
    // MARK: Best Offer Subject
    private var bestOfferViewModelSubject = PublishSubject<OfferViewModel>()
    public var bestOfferViewModelObs: Observable<OfferViewModel> {
        return bestOfferViewModelSubject.asObservable()
    }
    
    // MARK: Error Management
    private var needsDisplayErrorSubject = PublishSubject<LibraryError>()
    public var needsDisplayErrorObs: Observable<String> {
        return needsDisplayErrorSubject.asObservable().map { $0.description }
    }
    
    init(businessService: OrderRecapBusinessService, bookSelectionViewModels: [BookViewModel]) {
        self.model = bookSelectionViewModels
        self.orderRecapBusinessService = businessService
        
        fetchBestOffer()
    }
    
    private func fetchBestOffer() {
        let bookIdentifiers = model.map { $0.bookIdentifier }
        let orderAmount = model.compactMap { $0.bookPrice }.reduce(0, +)
        
        orderRecapBusinessService.fetchBestOffer(for: bookIdentifiers, orderAmount: orderAmount) { [weak self] (result: Result<BestOffer, LibraryError>) in
            switch result {
            case .success(let bestOffer):
                let bestOfferViewModel = OfferViewModel(bestOffer: bestOffer)
                self?.bestOfferViewModelSubject.onNext(bestOfferViewModel)
                break
                
            case .failure(let libraryError):
                self?.needsDisplayErrorSubject.onNext(libraryError)
                break
            }
        }
    }
}
