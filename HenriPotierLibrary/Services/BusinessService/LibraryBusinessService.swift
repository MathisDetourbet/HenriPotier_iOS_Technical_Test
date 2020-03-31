//
//  LibraryBusinessService.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 21/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation

final class LibraryBusinessService {
    
    private let dataAccess: DataAccess
    
    init(dataAccess: DataAccess) {
        self.dataAccess = dataAccess
    }
    
    func fetchBooks(completionHandler: @escaping (Result<[Book], LibraryError>) -> Void) {
        
        dataAccess.fetchBooks { result in
            switch result {
            case .success(let books):
                completionHandler(.success(books))
                
            case .failure(let apiError):
                completionHandler(.failure(LibraryError(from: apiError)))
            }
        }
    }
}
