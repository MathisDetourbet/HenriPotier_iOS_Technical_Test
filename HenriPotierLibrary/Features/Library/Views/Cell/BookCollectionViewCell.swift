//
//  BookCollectionViewCell.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 19/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

protocol BookCellPresenter {
    var bookCoverUrlObs: Observable<URL?> { get }
    var bookTitleObs: Observable<String> { get }
    var bookPriceObs: Observable<String> { get }
}

class BookCollectionViewCell: UICollectionViewCell {
    
    public static let cellIdentifier = "idBookCollectionViewCell"

    @IBOutlet private weak var bookCoverImageView: UIImageView!
    @IBOutlet private weak var bookTitleLabel: UILabel!
    @IBOutlet private weak var bookPriceLabel: UILabel!
    
    private var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
    
    private func setupUI() {
        backgroundColor = .darkGray
    }
    
    public func fill(with presenter: BookCellPresenter) {
        presenter.bookCoverUrlObs
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: { [weak self] imageUrl in
                self?.bookCoverImageView.kf.setImage(with: imageUrl)
            }).disposed(by: disposeBag)
        
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
