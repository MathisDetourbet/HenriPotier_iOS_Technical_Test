//
//  OfferViewModel.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 22/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation
import RxSwift

final class OfferViewModel: BestOfferViewPresenter {
    
    private let bestOffer: BestOffer
    
    private var offerTypeSubject: BehaviorSubject<String>
    public var offerTypeObs: Observable<String> {
        return offerTypeSubject.asObservable()
    }
    
    private var offerValueSubject: BehaviorSubject<String>
    public var offerValueObs: Observable<String> {
        return offerValueSubject.asObservable()
    }
    
    private var orderAmountSubject: BehaviorSubject<String>
    public var orderAmountObs: Observable<String> {
        return orderAmountSubject.asObservable()
    }
    
    private var orderAmountWithOfferSubject: BehaviorSubject<String>
    public var orderAmountWithOfferObs: Observable<String> {
        return orderAmountWithOfferSubject.asObservable()
    }
    
    init(bestOffer: BestOffer) {
        self.bestOffer = bestOffer
        
        offerTypeSubject = BehaviorSubject<String>(value: bestOffer.offerType.description)
        offerValueSubject = BehaviorSubject<String>(value: String.roundedDouble(value: bestOffer.offerValue))
        orderAmountSubject = BehaviorSubject<String>(value: String.roundedDouble(value: bestOffer.orderAmount) + " €")
        orderAmountWithOfferSubject = BehaviorSubject<String>(value: String.roundedDouble(value: bestOffer.orderAmountWithOffer) + " €")
    }
}
