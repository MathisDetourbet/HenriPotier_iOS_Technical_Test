//
//  Book.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 18/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation

struct Book: Decodable {
    
    let isbn: String
    let title: String
    let price: Double
    let cover: String
}
