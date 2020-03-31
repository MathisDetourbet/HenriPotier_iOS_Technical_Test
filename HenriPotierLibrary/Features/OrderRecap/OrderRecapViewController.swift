//
//  BasketViewController.swift
//  HenriPotierLibrary
//
//  Created by Mathis Detourbet on 18/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import UIKit
import RxSwift

protocol OrderRecapRoutingDelegate: class {
    func didCloseOrderRecap()
}

final class OrderRecapViewController: UIViewController {
    
    // MARK: IB Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var offerContainerView: UIView!
    
    // MARK: Private properties
    private var bestOfferView: BestOfferView
    private let disposeBag = DisposeBag()
    private let orderRecapViewModel: OrderRecapViewModel
    private weak var routingDelegate: OrderRecapRoutingDelegate?
    
    // MARK: Init
    init(viewModel: OrderRecapViewModel, routingDelegate: OrderRecapRoutingDelegate) {
        self.orderRecapViewModel = viewModel
        self.bestOfferView = BestOfferView.loadFromNib()
        self.routingDelegate = routingDelegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindToViewModel()
    }
    
    private func setupUI() {
        setupTableView()
        setupBestOfferView()
    }
    
    private func setupTableView() {
        let bookCellNib = UINib(nibName: String(describing: BookTableViewCell.self), bundle: Bundle.main)
        tableView.register(bookCellNib.self, forCellReuseIdentifier: BookTableViewCell.cellIdentifier)
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.tableFooterView = UIView()
    }
    
    private func setupBestOfferView() {
        offerContainerView.addSubview(bestOfferView)
        bestOfferView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: bestOfferView, attribute: .top, relatedBy: .equal, toItem: offerContainerView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: bestOfferView, attribute: .leading, relatedBy: .equal, toItem: offerContainerView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: bestOfferView, attribute: .trailing, relatedBy: .equal, toItem: offerContainerView, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: bestOfferView, attribute: .bottom, relatedBy: .equal, toItem: offerContainerView, attribute: .bottom, multiplier: 1, constant: 0)
        ])
    }
    
    private func bindToViewModel() {
        // Bind to best offer view model
        orderRecapViewModel.bestOfferViewModelObs
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] bestOfferVM in
                DispatchQueue.main.async {
                    self?.bestOfferView.configure(with: bestOfferVM)
                }
            }).disposed(by: disposeBag)
        
        // Bind to error
        orderRecapViewModel.needsDisplayErrorObs
            .asDriver(onErrorJustReturn: "Unknown error")
            .drive(onNext: { [weak self] errorDescription in
                self?.displayError(withDescription: errorDescription)
            }).disposed(by: disposeBag)
    }
    
    // MARK: IB Actions
    @IBAction func closeButtonTouched(_ sender: UIButton) {
        routingDelegate?.didCloseOrderRecap()
    }
}

// MARK: - Table View Data Source
extension OrderRecapViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return orderRecapViewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderRecapViewModel.numberOfItemsIn(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.cellIdentifier) as? BookTableViewCell else {
            fatalError()
        }
        
        let bookViewModel = orderRecapViewModel.elementAt(indexPath)
        cell.fill(with: bookViewModel)
        
        return cell
    }
}
