//
//  Offer.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 18/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation

struct Offer {
    
    enum OfferType: CustomStringConvertible {
        case percentage
        case minus
        case slice(value: Double)
        case noOffer
        
        init(typeString: String) {
            switch typeString {
            case "percentage":
                self = .percentage
            case "minus":
                self = .minus
            default:
                // case slice has already been checked before, so it can't be that case.
                self = .noOffer
            }
        }

        var description: String {
            switch self {
            case .percentage: return "Percentage offer"
            case .minus: return "Deduction offer"
            case .slice: return "Slice offer"
            case .noOffer: return "No offer can be apply."
            }
        }
    }
    
    let type: OfferType
    let value: Double
    
    // Get the order amount with offer applied
    func offerForOrderAmount(_ orderAmount: Double) -> Double {
        switch type {
        case .percentage:
            return orderAmount * (1 - (value / 100))
            
        case .minus:
            return orderAmount - value
            
        case .slice(let sliceValue):
            return orderAmount - Double((Int(orderAmount / sliceValue))) * Double(value)
            
        case .noOffer:
            return orderAmount
        }
    }
}

extension Offer: Decodable {
    
    private enum OfferCodingKeys: String, CodingKey {
        case type
        case value
        case sliceValue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: OfferCodingKeys.self)
        
        if let sliceValue = try? container.decodeIfPresent(Double.self, forKey: .sliceValue) {
            type = OfferType.slice(value: sliceValue)
        
        } else {
            let offerTypeString = try container.decode(String.self, forKey: .type)
            type = OfferType(typeString: offerTypeString)
        }
        value = try container.decode(Double.self, forKey: .value)
    }
}
