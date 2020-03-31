//
//  BestOfferView.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 22/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import UIKit
import RxSwift

protocol BestOfferViewPresenter {
    var offerTypeObs: Observable<String> { get }
    var offerValueObs: Observable<String> { get }
    var orderAmountObs: Observable<String> { get }
    var orderAmountWithOfferObs: Observable<String> { get }
}

final class BestOfferView: UIView, NibOwnerLoadable {
    
    private let disposeBag = DisposeBag()

    @IBOutlet private weak var offerTypeLabel: UILabel!
    @IBOutlet private weak var offerValueLabel: UILabel!
    @IBOutlet private weak var orderAmountLabel: UILabel!
    @IBOutlet private weak var orderAmountWithOfferLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public func configure(with presenter: BestOfferViewPresenter) {
        presenter.offerTypeObs
            .asDriver(onErrorJustReturn: "-")
            .drive(offerTypeLabel.rx.text)
            .disposed(by: disposeBag)
        
        presenter.offerValueObs
            .asDriver(onErrorJustReturn: "-")
            .drive(offerValueLabel.rx.text)
            .disposed(by: disposeBag)
        
        presenter.orderAmountObs
            .asDriver(onErrorJustReturn: "-")
            .drive(orderAmountLabel.rx.text)
            .disposed(by: disposeBag)
        
        presenter.orderAmountWithOfferObs
            .asDriver(onErrorJustReturn: "-")
            .drive(orderAmountWithOfferLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
