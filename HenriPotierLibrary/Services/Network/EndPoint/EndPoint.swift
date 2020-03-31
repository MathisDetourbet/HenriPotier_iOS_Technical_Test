//
//  EndPoint.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 19/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation

enum EndPoint: CustomStringConvertible {
    case books
    case offers(_ bookIdentifiers: [String])
    
    internal var description: String {
        switch self {
        case .books:
            return "http://henri-potier.xebia.fr/books"
            
        case .offers(let bookIdentifiers):
            return "http://henri-potier.xebia.fr/books/\(bookIdentifiers.joined(separator: ","))/commercialOffers"
        }
    }
    
    public var url: URL? {
        return URL(string: description)
    }
}
