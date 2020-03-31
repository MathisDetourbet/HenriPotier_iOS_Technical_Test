//
//  UIView+Animation.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 22/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import UIKit

extension UIView {
    
    func bounce () {
        self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 6.0,
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: { [weak self] in
                        self?.transform = CGAffineTransform.identity
        },
                       completion: { _ in ()  }
        )
    }
}
