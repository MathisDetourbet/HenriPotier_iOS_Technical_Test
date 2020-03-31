//
//  NetworkLayer.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 18/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation

protocol NetworkLayer {
    func sendRequest<T: Decodable>(with url: URL, completionHandler: @escaping NetworkCompletionHandler<T>)
}
