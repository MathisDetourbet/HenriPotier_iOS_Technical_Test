//
//  String+RoundedDouble.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 23/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation

extension String {
    
    static func roundedDouble(value: Double) -> String {
        return String(format: "%.2f", value)
    }
}
