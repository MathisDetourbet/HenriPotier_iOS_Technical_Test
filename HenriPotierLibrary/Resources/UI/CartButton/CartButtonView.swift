//
//  CartButtonView.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 21/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import UIKit
import RxSwift

// MARK: - Cart Button View Delegate
protocol CartButtonViewDelegate: class {
    /// Number of books selected. Number displayed on the cart button top left corner.
    var booksCounterObs: Observable<Int> { get }
    
    /// Cart button touched action. Should present the order recap.
    func cartButtonTouched()
}

// MARK: - Cart Button View
final class CartButtonView: UIView {

    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var cartButton: UIButton! {
        didSet { self.cartButton.isEnabled = false }
    }
    @IBOutlet private weak var booksCounterLabel: UILabel!
    
    private static let cartButtonSize = 60
    private let disposeBag = DisposeBag()
    public weak var delegate: CartButtonViewDelegate?
    
    @discardableResult
    static func addCartButtonView(to view: UIView, delegate: CartButtonViewDelegate?) -> CartButtonView? {
        let nibName = String(describing: CartButtonView.self)
        
        guard let cartButtonView = UINib(nibName: nibName, bundle: Bundle.main).instantiate(withOwner: nil, options: nil).first as? CartButtonView else {
            return nil
        }
        
        cartButtonView.delegate = delegate
        cartButtonView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cartButtonView)

        // Setup constraints
        NSLayoutConstraint.activate([
            cartButtonView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            cartButtonView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10),
            cartButtonView.heightAnchor.constraint(equalToConstant: CGFloat(cartButtonSize)),
            cartButtonView.widthAnchor.constraint(equalToConstant: CGFloat(cartButtonSize))
        ])
        
        // Bind to view model
        delegate?.booksCounterObs
            .filter { $0 > 0 }
            .subscribe(onNext: { [weak cartButtonView] booksNumber in
                cartButtonView?.booksCounterLabel.isHidden = false
                cartButtonView?.booksCounterLabel.text = String(booksNumber)
                cartButtonView?.booksCounterLabel.bounce()
                cartButtonView?.cartButton.isEnabled = booksNumber > 0
            })
            .disposed(by: cartButtonView.disposeBag)
        
        return cartButtonView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        setNeedsLayout()
        
        // Setup shadow design
        shadowView.layer.masksToBounds = false
        shadowView.layer.cornerRadius = shadowView.frame.size.width / 2
        shadowView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 2)
        shadowView.layer.shadowOpacity = 1.0
        shadowView.layer.shadowRadius = 4.0
        
        // Setup counter label design
        booksCounterLabel.layer.masksToBounds = true
        booksCounterLabel.layer.cornerRadius = booksCounterLabel.frame.size.width / 2
        booksCounterLabel.isHidden = true
        
        // Setup cart button design
        cartButton.layer.masksToBounds = true
        cartButton.layer.cornerRadius = cartButton.frame.size.width / 2
    }
    
    @IBAction func cartButtonTouched(_ sender: UIButton) {
        delegate?.cartButtonTouched()
    }
}
