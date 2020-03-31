//
//  ViewController.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 18/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import UIKit
import RxSwift

// MARK: - Library Routing Delegate
protocol LibraryRoutingDelegate: class {
    func showOrderRecap(for bookSelection: [BookViewModel])
}

// MARK: - Library View Controller
final class LibraryViewController: UIViewController {
    
    // MARK: Private Properties
    private let disposeBag = DisposeBag()
    private let libraryViewModel: LibraryViewModel
    private weak var collectionView: UICollectionView?
    private weak var bookSelectionDelegate: BookSelectionDelegate?
    
    fileprivate lazy var sizeForItem: CGSize = {
        let numberOfItemByRow = CGFloat(CollectionViewLayoutProperties.numberOfItemByRow)
        let collectionWidth = self.collectionView?.frame.width
        let columnsSpacing = CollectionViewLayoutProperties.minimumItemsSpacing
        let itemWidth = (collectionWidth ?? self.view.frame.width) / numberOfItemByRow - CollectionViewLayoutProperties.collectionHorizontalInset
        let itemHeight = itemWidth * CollectionViewLayoutProperties.cellAspectRatio
        
        return CGSize(width: itemWidth, height: itemHeight)
    }()
    
    // MARK: Init
    init(viewModel: LibraryViewModel) {
        self.libraryViewModel = viewModel
        self.bookSelectionDelegate = libraryViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        buildUI()
        bindToViewModel()
    }
    
    private func buildUI() {
        // Build & Config CollectionView
        collectionView = makeCollectionView()
        
        // Build & Config Cart Button
        CartButtonView.addCartButtonView(to: view, delegate: libraryViewModel)
    }
    
    private func bindToViewModel() {
        // Bind to collection view reload flag
        libraryViewModel.needsCollectionViewReloadObs
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] _ in
                self?.collectionView?.reloadData()
            }).disposed(by: disposeBag)
        
        // Bind to error management
        libraryViewModel.needsDisplayErrorObs
            .asDriver(onErrorJustReturn: "Unknown error")
            .drive(onNext: { [unowned self] errorDescription in
                self.displayError(withDescription: errorDescription)
            }).disposed(by: disposeBag)
    }
}

// MARK: - Collection View Setup
extension LibraryViewController {
    
    enum CollectionViewLayoutProperties {
        public static let numberOfItemByRow: Int = 2
        public static let cellAspectRatio: CGFloat = 3/2
        public static let minimumItemsSpacing: CGFloat = 0.0
        public static let collectionHorizontalInset: CGFloat = 5.0
    }
    
    private func makeCollectionView() -> UICollectionView {
        
        func makeCollectionViewLayout() -> UICollectionViewFlowLayout {
            let itemsHorizontalInset = CollectionViewLayoutProperties.minimumItemsSpacing
            
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = sizeForItem
            flowLayout.minimumInteritemSpacing = CollectionViewLayoutProperties.minimumItemsSpacing
            flowLayout.minimumLineSpacing = CollectionViewLayoutProperties.minimumItemsSpacing
            flowLayout.sectionInset = UIEdgeInsets(top: 0.0, left: itemsHorizontalInset, bottom: 0.0, right: itemsHorizontalInset)
            flowLayout.scrollDirection = .vertical
            
            return flowLayout
        }
        
        let collectionViewLayout = makeCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        ])
        
        let bookCollectionViewCellNib = UINib(nibName: String(describing: BookCollectionViewCell.self), bundle: Bundle.main)
        collectionView.register(bookCollectionViewCellNib.self, forCellWithReuseIdentifier: BookCollectionViewCell.cellIdentifier)
        
        return collectionView
    }
}

// MARK: - Collection View Data Source
extension LibraryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return libraryViewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return libraryViewModel.numberOfItemsIn(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.cellIdentifier, for: indexPath) as? BookCollectionViewCell else {
            fatalError("Error dequeue reusable cell. Identifier is probably wrong.")
        }
        
        let bookCellPresenter = libraryViewModel.elementAt(indexPath)
        cell.fill(with: bookCellPresenter)
        
        return cell
    }
}

// MARK: - Collection View Delegate
extension LibraryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        bookSelectionDelegate?.didSelectBookAt(indexPath)
    }
}
