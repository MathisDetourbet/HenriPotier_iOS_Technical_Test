//
//  OffersResponse.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 19/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation

struct OffersResponse: Decodable {
    
    let offers: [Offer]
}
