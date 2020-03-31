//
//  MockFactory.swift
//  HenriPotierLibraryTests
//
//  Created by Mathis Detourbet on 23/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation
import Alamofire
@testable import HenriPotierLibrary

class MockFactory {
    
    public static var mockNetworkService: NetworkLayer {
        return MockNetworkService()
    }
    
    public static var mockApiDataAccess: DataAccess {
        return MockApiDataAccess(networkService: mockNetworkService)
    }
    
    public static var mockLibraryBusinessService: LibraryBusinessService {
        return LibraryBusinessService(dataAccess: mockApiDataAccess)
    }
    
    public static var mockOrderRecapBusinessService: OrderRecapBusinessService {
        return OrderRecapBusinessService(dataAccess: mockApiDataAccess)
    }
}

class MockNetworkService: NetworkLayer {
    
    func sendRequest<T>(with url: URL, completionHandler: @escaping (Result<T, AFError>) -> Void) where T : Decodable {
        do {
            let data = try Data(contentsOf: url)
            let jsonDecoder = JSONDecoder()
            let decodedObject = try jsonDecoder.decode(T.self, from: data)
            completionHandler(.success(decodedObject))
        } catch {
            completionHandler(.failure(AFError.createURLRequestFailed(error: error)))
        }
    }
}

class MockApiDataAccess: DataAccess {
    let networkService: NetworkLayer
    
    init(networkService: NetworkLayer) {
        self.networkService = networkService
    }
    
    func fetchBooks(completionHandler: @escaping (Result<[Book], ApiError>) -> Void) {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: "fetchBooksJSON", ofType: "json") else {
            completionHandler(.failure(ApiError.clientError))
            return
        }
        let fileUrl = URL(fileURLWithPath: path)
        networkService.sendRequest(with: fileUrl) { (result: Result<[Book], AFError>) in
            switch result {
            case .success(let books):
                completionHandler(.success(books))
                break
            case .failure(let afError):
                completionHandler(.failure(ApiError(from: afError)))
                break
            }
        }
    }
    
    func fetchOffers(for bookIdentifiers: [String], completionHandler: @escaping (Result<[Offer], ApiError>) -> Void) {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: "fetchOffersJSON", ofType: "json") else {
            completionHandler(.failure(ApiError.clientError))
            return
        }
        let fileUrl = URL(fileURLWithPath: path)
        networkService.sendRequest(with: fileUrl) { (result: Result<OffersResponse, AFError>) in
            switch result {
            case .success(let offerResponse):
                completionHandler(.success(offerResponse.offers))
                break
            case .failure(let afError):
                completionHandler(.failure(ApiError(from: afError)))
                break
            }
        }
    }
}

class MockLibraryRoutingDelegate: LibraryRoutingDelegate {
    
    var showOrderRecapHasBeenCalled: Bool = false
    var bookSelectionIsEmpty: Bool = true
    
    func showOrderRecap(for bookSelection: [BookViewModel]) {
        showOrderRecapHasBeenCalled = true
        bookSelectionIsEmpty = bookSelection.isEmpty
    }
}
