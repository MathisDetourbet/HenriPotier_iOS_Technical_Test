//
//  ApiDataAccess.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 19/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation
import Alamofire

final class ApiDataAccess {
    
    private let networkService: NetworkLayer
    
    init(networkService: NetworkLayer) {
        self.networkService = networkService
    }
}

extension ApiDataAccess: DataAccess {
    
    func fetchBooks(completionHandler: @escaping (Result<[Book], ApiError>) -> Void) {
        guard let url = EndPoint.books.url else {
            return
        }
        
        networkService.sendRequest(with: url) { (result: Result<[Book], AFError>) in
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
        guard let url = EndPoint.offers(bookIdentifiers).url else {
            return
        }
        
        networkService.sendRequest(with: url) { (result: Result<OffersResponse, AFError>) in
            switch result {
            case .success(let offersResponse):
                completionHandler(.success(offersResponse.offers))
                break
                
            case .failure(let afError):
                completionHandler(.failure(ApiError(from: afError)))
                break
            }
        }
    }
}
