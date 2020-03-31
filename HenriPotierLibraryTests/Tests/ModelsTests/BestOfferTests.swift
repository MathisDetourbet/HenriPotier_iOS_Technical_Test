//
//  BestOfferTests.swift
//  HenriPotierLibraryTests
//
//  Created by Mathis Detourbet on 24/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import XCTest
@testable import HenriPotierLibrary

extension Offer.OfferType: Equatable {
    public static func == (lhs: Offer.OfferType, rhs: Offer.OfferType) -> Bool {
        switch (lhs, rhs) {
        case (.percentage, .percentage), (.minus, .minus), (.noOffer, .noOffer):
            return true
        case (.slice(let vlhs), .slice(let vrhs)):
            return vlhs == vrhs
        default:
            return false
        }
    }
}

class BestOfferTests: XCTestCase {
    
    private var bestOfferModel: BestOffer!

    override func setUp() {
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_Init_Should_Set_Properties_When_Offer_Model_Not_Nil() {
        let offerValue = 12.0
        let offer = Offer(type: .percentage, value: offerValue)
        let orderAmountWithOffer = 79.2
        self.bestOfferModel = BestOffer(offer: offer, orderAmount: 90.0)
        XCTAssert(bestOfferModel.offerType == Offer.OfferType.percentage, "BestOffer should of type percentage")
        XCTAssert(bestOfferModel.offerValue == offerValue, "BestOffer should set its value to the same value contained in offer model")
        XCTAssert(bestOfferModel.orderAmountWithOffer == orderAmountWithOffer, "BestOffer orderAmountWithOffer should display the right result.")
    }
    
    func test_Init_Should_Set_Properties_When_Offer_Model_Is_Nil() {
        let orderAmount = 90.0
        self.bestOfferModel = BestOffer(offer: nil, orderAmount: orderAmount)
        XCTAssert(bestOfferModel.offerType == Offer.OfferType.noOffer, "BestOffer should of type noOffer")
        XCTAssert(bestOfferModel.offerValue == 0.0, "BestOffer should be 0 because offer is nil")
        XCTAssert(bestOfferModel.orderAmountWithOffer == orderAmount, "BestOffer orderAmountWithOffer should display the order amount")
    }
}
