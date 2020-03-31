//
//  OrderRecapBusinessServiceTests.swift
//  HenriPotierLibraryTests
//
//  Created by Mathis Detourbet on 24/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import XCTest
@testable import HenriPotierLibrary

class OrderRecapBusinessServiceTests: XCTestCase {
    
    private var orderRecapBusinessService: OrderRecapBusinessService!

    override func setUp() {
        orderRecapBusinessService = OrderRecapBusinessService(dataAccess: MockFactory.mockApiDataAccess)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_fetchOffer_Should_Return_Minus_As_BestOffer() {
        orderRecapBusinessService.fetchBestOffer(for: [], orderAmount: 100.0) { (result: Result<BestOffer, LibraryError>) in
            switch result {
            case .success(let bestOffer):
                XCTAssert(bestOffer.offerType == .minus, "Best offer should be a minus offer")
                break
                
            case .failure(_): XCTFail("Result is a failure")
            }
        }
    }
    
    func test_fetchOffer_Should_Return_Slice_As_BestOffer() {
        orderRecapBusinessService.fetchBestOffer(for: [], orderAmount: 355.0) { (result: Result<BestOffer, LibraryError>) in
            switch result {
            case .success(let bestOffer):
                XCTAssert(bestOffer.offerType == .slice(value: 100), "Best offer should be a minus offer")
                break
                
            case .failure(_): XCTFail("Result is a failure")
            }
        }
    }
}
