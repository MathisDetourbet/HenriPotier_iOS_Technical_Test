//
//  ApiDataAccessTests.swift
//  HenriPotierLibraryTests
//
//  Created by Mathis Detourbet on 25/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import XCTest
@testable import HenriPotierLibrary

class ApiDataAccessTests: XCTestCase {
    
    private var apiDataAccess: ApiDataAccess!

    override func setUp() {
        apiDataAccess = ApiDataAccess(networkService: MockFactory.mockNetworkService)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_FetchBooks_Should_Fetch_All_Books_Without_Any_Error() {
        apiDataAccess.fetchBooks { (result: Result<[Book], ApiError>) in
            switch result {
            case .success(let books):
                XCTAssertFalse(books.isEmpty, "Fetch books should return seven books")
                XCTAssert(books.count == 7, "Fetch books should return seven books")
                break
            case .failure(let apiError):
                XCTFail("Fetch books gives a failure. Error: \(apiError.localizedDescription)")
            }
        }
    }
    
    func test_Offers_Should_Fetch_Without_Any_Error() {
        let bookIdentifiers = ["fcd1e6fa-a63f-4f75-9da4-b560020b6acc", "fcd1e6fa-a63f-4f75-9da4-b560020b6acc", "fcd1e6fa-a63f-4f75-9da4-b560020b6acc"]
        apiDataAccess.fetchOffers(for: bookIdentifiers) { (result: Result<[Offer], ApiError>) in
            switch result {
            case .success(let offers):
                XCTAssertFalse(offers.isEmpty, "Fetch offer should return three offers")
                XCTAssert(offers.count == 3, "Fetch offer should return three offers")
                break
            case .failure(let apiError):
                XCTFail("Fetch books gives a failure. Error: \(apiError.localizedDescription)")
            }
        }
    }
}
