//
//  LibraryError.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 21/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation

enum LibraryError: Error, CustomStringConvertible {
    case retryLater
    case retryLaterOrAskSupport
    
    init(from apiError: ApiError) {
        
        switch apiError {
        case .clientError, .decodingError:
            self = .retryLaterOrAskSupport
        case .serverError, .unknown:
            self = .retryLater
        }
    }
    
    var description: String {
        switch self {
        case .retryLater:
            return "Something went wrong. Please retry your request later."
        case .retryLaterOrAskSupport:
            return "Something went wrong. Please retry your request. If you still get the same error, we advice you to ask to the support team."
        }
    }
}
