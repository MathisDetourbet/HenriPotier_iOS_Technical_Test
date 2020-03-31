//
//  BestOffer.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 23/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation

struct BestOffer {
    
    let offerType: Offer.OfferType
    let offerValue: Double
    let orderAmount: Double
    let orderAmountWithOffer: Double
    
    init(offer: Offer?, orderAmount: Double) {
        
        guard let offer = offer else {
            self.offerType = .noOffer
            self.offerValue = 0
            self.orderAmount = orderAmount
            self.orderAmountWithOffer = orderAmount
            return
        }
        
        self.offerType = offer.type
        self.offerValue = offer.value
        self.orderAmount = orderAmount
        self.orderAmountWithOffer = offer.offerForOrderAmount(orderAmount)
    }
}
