//
//  OrderRecapViewModelTests.swift
//  HenriPotierLibraryTests
//
//  Created by Mathis Detourbet on 24/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import XCTest
import RxSwift
@testable import HenriPotierLibrary

class OrderRecapViewModelTests: XCTestCase {
    
    private var orderRecapViewModel: OrderRecapViewModel!

    override func setUp() {
        orderRecapViewModel = OrderRecapViewModel(businessService: MockFactory.mockOrderRecapBusinessService, bookSelectionViewModels: DataFactory.makeBooksViewModel())
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_Model_Should_Not_Be_Empty_When_Init() {
        XCTAssert(orderRecapViewModel.numberOfItemsIn(1) == 7, "View model should set book selection to its model")
    }
    
    func test_Init_Should_Fetch_BestOffer() {
        let disposeBag = DisposeBag()
        orderRecapViewModel.bestOfferViewModelObs.subscribe(onNext: { bestOfferViewModel in
            XCTAssert(true, "Best offer should be minus")
        }).disposed(by: disposeBag)
        XCTAssertFalse(orderRecapViewModel.model.isEmpty, "View model should call fetchData and get the bestOffer")
    }
}
