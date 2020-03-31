//
//  BookTableViewCell.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 22/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import UIKit
import RxSwift

class BookTableViewCell: UITableViewCell {
    
    public static let cellIdentifier = "idBookTableViewCell"
    
    @IBOutlet private weak var bookTitleLabel: UILabel!
    @IBOutlet private weak var bookPriceLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func fill(with presenter: BookCellPresenter) {
        presenter.bookTitleObs
            .asDriver(onErrorJustReturn: "")
            .drive(bookTitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        presenter.bookPriceObs
            .asDriver(onErrorJustReturn: "- €")
            .drive(bookPriceLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
