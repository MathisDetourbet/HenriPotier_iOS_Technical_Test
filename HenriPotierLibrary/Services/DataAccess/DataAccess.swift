//
//  DataAccess.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 19/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation

protocol DataAccess {
    func fetchBooks(completionHandler: @escaping (Result<[Book], ApiError>) -> Void)
    func fetchOffers(for bookIdentifiers: [String], completionHandler: @escaping (Result<[Offer], ApiError>) -> Void)
}
