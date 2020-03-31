//
//  CollectionViewModel.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 19/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation

protocol CollectionViewModel {
    associatedtype Model: Sequence
    var model: Model { get }
    
    var numberOfSections: Int { get }
    
    func numberOfItemsIn(_ section: Int) -> Int
    func elementAt(_ indexPath: IndexPath) -> Model.Element
}

extension CollectionViewModel where Model: Collection {
    var numberOfSections: Int { return 1 }
    
    func numberOfItemsIn(_ section: Int) -> Int {
        return model.count
    }
    
    func elementAt(_ indexPath: IndexPath) -> Model.Element {
        guard case 0...model.count = indexPath.row else {
            fatalError("model object cannot be found at row: \(indexPath.row)!")
        }
        let index = model.index(model.startIndex, offsetBy: indexPath.row)
        return model[index]
    }
}
