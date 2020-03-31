//
//  OfferTests.swift
//  HenriPotierLibraryTests
//
//  Created by Mathis Detourbet on 24/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import XCTest
@testable import HenriPotierLibrary

class OfferTests: XCTestCase {
    
    private var offerModel: Offer!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_OfferForOrderAmount_Should_Return_Order_Amount_With_Percentage_Offer() {
        let result = 90.0 // deduction of 10% of 100 = 90
        offerModel = Offer(type: .percentage, value: 10.0)
        XCTAssert(offerModel.offerForOrderAmount(100.0) == result, "Offer should return the right order amount given a percentage offer of 10%")
    }
    
    func test_OfferForOrderAmount_Should_Return_Order_Amount_With_Minus_Offer() {
        let result = 90.0 // deduction of 10 of 100 = 90
        offerModel = Offer(type: .minus, value: 10.0)
        XCTAssert(offerModel.offerForOrderAmount(100.0) == result, "Offer should return the right order amount given a minus offer of 10")
    }
    
    func test_OfferForOrderAmount_Should_Return_Order_Amount_With_Slice_Offer() {
        let result = 90.0 // deduction of 10 every 100 of 100 = 90
        offerModel = Offer(type: .slice(value: 100.0), value: 10.0)
        XCTAssert(offerModel.offerForOrderAmount(100.0) == result, "Offer should return the right order amount given a slice offer of 10 every 100")
    }
}
