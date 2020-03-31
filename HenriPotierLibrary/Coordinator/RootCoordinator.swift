//
//  RootCoordinator.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 22/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import UIKit

class RootCoordinator {
    
    private let networkService: NetworkLayer
    private let apiDataAccess: DataAccess
    
    var rootViewController: LibraryViewController?
    
    init() {
        self.networkService = NetworkService()
        self.apiDataAccess = ApiDataAccess(networkService: networkService)
        
        let libraryBusinessService = LibraryBusinessService(dataAccess: apiDataAccess)
        let libraryViewModel = LibraryViewModel(businessService: libraryBusinessService, routingDelegate: self)
        self.rootViewController = LibraryViewController(viewModel: libraryViewModel)
    }
}

extension RootCoordinator: LibraryRoutingDelegate {
    
    func showOrderRecap(for bookSelection: [BookViewModel]) {
        let orderRecapBusinessService = OrderRecapBusinessService(dataAccess: apiDataAccess)
        let orderRecapViewModel = OrderRecapViewModel(businessService: orderRecapBusinessService, bookSelectionViewModels: bookSelection)
        let orderRecapViewController = OrderRecapViewController(viewModel: orderRecapViewModel, routingDelegate: self)
        
        rootViewController?.present(orderRecapViewController, animated: true)
    }
}

extension RootCoordinator: OrderRecapRoutingDelegate {
    
    func didCloseOrderRecap() {
        rootViewController?.dismiss(animated: true, completion: nil)
    }
}
