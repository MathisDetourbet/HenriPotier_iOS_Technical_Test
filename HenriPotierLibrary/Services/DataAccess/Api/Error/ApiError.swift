//
//  ApiError.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 19/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation
import Alamofire

enum ApiError: Error {
    case clientError
    case serverError
    case decodingError
    case unknown
    
    init(from afError: AFError) {
        if let responseCode = afError.responseCode {
            switch responseCode {
            case 400..<500:
                self = .clientError
            case 500..<600:
                self = .serverError
            default:
                self = .unknown
            }
        } else if afError.isResponseSerializationError {
            self = .decodingError
        } else {
            self = .unknown
        }
    }
}
