//
//  LibraryViewModelTests.swift
//  HenriPotierLibraryTests
//
//  Created by Mathis Detourbet on 24/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import XCTest
import Alamofire
import RxSwift
@testable import HenriPotierLibrary

class LibraryViewModelTests: XCTestCase {
    
    private var libraryViewModel: LibraryViewModel!
    private let mockLibraryRoutingDelegate = MockLibraryRoutingDelegate()

    override func setUp() {
        libraryViewModel = LibraryViewModel(businessService: MockFactory.mockLibraryBusinessService, routingDelegate: mockLibraryRoutingDelegate)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_Model_Should_Fetch_Data_When_Init() {
        XCTAssert(libraryViewModel.model.isEmpty == false)
    }
    
    func test_NumberOfSection_Should_Return_One() {
        XCTAssert(libraryViewModel.numberOfSections == 1, "Number of section should be equal to 1")
    }
    
    func test_NumberOfItem_Should_Return_Number_Of_Books_Fetched() {
        XCTAssert(libraryViewModel.numberOfItemsIn(1) == 7, "Number of items should be equal to the number of books fetched (7 books in the json file)")
    }
    
    func test_CartButtonTouched_Should_Call_ShowOrderRecap_With_Books_Selection() {
        // Touch the cart button to show order recap
        libraryViewModel.cartButtonTouched()
        XCTAssertTrue(mockLibraryRoutingDelegate.showOrderRecapHasBeenCalled, "This flag should be true because cartButtonTouched has been called.")
        XCTAssertTrue(mockLibraryRoutingDelegate.bookSelectionIsEmpty, "Book Selection Should be empty")
        
        // Add book to selection
        libraryViewModel.didSelectBookAt(IndexPath(item: 1, section: 0))
        libraryViewModel.cartButtonTouched()
        XCTAssertFalse(mockLibraryRoutingDelegate.bookSelectionIsEmpty, "Book Selection Should NOT be empty")
    }
}
