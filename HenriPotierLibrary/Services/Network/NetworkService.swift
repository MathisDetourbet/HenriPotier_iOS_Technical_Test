//
//  NetworkService.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 19/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation
import Alamofire

public typealias NetworkCompletionHandler<T: Decodable> = (Result<T, AFError>) -> Void

final class NetworkService: NetworkLayer {

    func sendRequest<T: Decodable>(with url: URL, completionHandler: @escaping NetworkCompletionHandler<T>) {
        AF
            .request(url)
            .validate()
            .responseDecodable(of: T.self) { dataResponse in
                switch dataResponse.result {
                case .success(let decodedObject):
                    completionHandler(.success(decodedObject))
                    break
                
                case .failure(let afError):
                    completionHandler(.failure(afError))
                    break
                }
        }
    }
}
