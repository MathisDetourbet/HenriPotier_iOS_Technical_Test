//
//  UIViewController+ErrorAlertView.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 22/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func displayError(withDescription description: String) {
        let alertController = UIAlertController(
            title: "Error",
            message: description,
            preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .cancel))
        present(alertController, animated: true)
    }
}
