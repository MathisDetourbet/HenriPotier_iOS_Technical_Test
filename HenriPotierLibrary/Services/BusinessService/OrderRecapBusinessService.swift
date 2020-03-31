//
//  OrderRecapBusinessService.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 22/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation

final class OrderRecapBusinessService {
    
    private let dataAccess: DataAccess
    
    init(dataAccess: DataAccess) {
        self.dataAccess = dataAccess
    }
    
    func fetchBestOffer(for bookIdentifiers: [String], orderAmount: Double, completionHandler: @escaping (Result<BestOffer, LibraryError>) -> Void) {
        dataAccess.fetchOffers(for: bookIdentifiers) { [weak self] (result: Result<[Offer], ApiError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let offers):
                let bestOffer = self.findBestOfferWithin(offers: offers, for: orderAmount)
                completionHandler(.success(bestOffer))
                break
                
            case .failure(let apiError):
                completionHandler(.failure(LibraryError(from: apiError)))
                break
            }
        }
    }
    
    private func findBestOfferWithin(offers: [Offer], for orderAmount: Double) -> BestOffer {
        let minOffer = offers.min { $0.offerForOrderAmount(orderAmount) < $1.offerForOrderAmount(orderAmount) }
        
        guard let offer = minOffer else {
            return BestOffer(offer: offers.first, orderAmount: orderAmount)
        }
        
        let bestOffer = BestOffer(offer: offer, orderAmount: orderAmount)
        return bestOffer
    }
}
