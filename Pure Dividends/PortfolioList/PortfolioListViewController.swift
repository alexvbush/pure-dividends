//
//  PortfolioViewController.swift
//  Pure Dividends
//
//  Created by Alex Bush on 6/29/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol PortfolioNavigationViewControllable: NavigationViewControllable {}

final class PortfolioNavigationViewController: UINavigationController, PortfolioNavigationViewControllable {}

protocol PortfolioListPresentableListener: class {
    func stockSelected(_ stock: StockModel)
}

final class PortfolioListViewController: UIViewController, PortfolioListPresentable, PortfolioListViewControllable, PortfolioListViewDelegate {

    weak var listener: PortfolioListPresentableListener?
    
    private lazy var internalView = PortfolioListView(delegate: self)
    
    private var stocksViewModels = [StockViewModel]()
    
//    private var stocksViewModels: [StockViewModel] {
//        return stocksModels.map { StockViewModel(stock: $0) }
        
        //        return stocksModels.map { StockViewModel(stock: $0) }.sorted(by: { (stockVM1, stockVM2) -> Bool in
        //            return stockVM1.ticker > stockVM2.ticker
        //        })
//    }
    
    override func loadView() {
        view = internalView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAddStockButtonButton()
    }
    
    private func setupAddStockButtonButton() {
        let addStockButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTap(_:)))        
        navigationItem.rightBarButtonItem = addStockButton
    }
    
    @objc private func addButtonTap(_ addButton: UIBarButtonItem) {
        
    }
    
    func present(stocks: [StockModel]) {
        stocksViewModels = stocks.map { StockViewModel(stock: $0) }
        internalView.reload()
    }
    
    // MARK: - BEGIN PortfolioViewDelegate
    func numberOfStocks() -> Int {
        return stocksViewModels.count
    }
    
    func stock(atIndex index: Int) -> StockViewModel {
        return stocksViewModels[index]
    }
    
    func didSelect(index: Int) {
        let selectedViewModel = stocksViewModels[index]
        listener?.stockSelected(selectedViewModel.stock)
    }
    // MARK: END PortfolioViewDelegate -
}

fileprivate protocol PortfolioListViewDelegate {
    func numberOfStocks() -> Int
    func stock(atIndex index: Int) -> StockViewModel
    func didSelect(index: Int)
}

fileprivate final class PortfolioListView: UIView, UITableViewDelegate, UITableViewDataSource {
    private let delegate: PortfolioListViewDelegate
    
    private let tableView: UITableView
    
    init(delegate: PortfolioListViewDelegate) {
        self.delegate = delegate
        self.tableView = UITableView()
        super.init(frame: .zero)
        
        backgroundColor = .purple
        
        setupTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    private func setupTableView() {
        addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(StockCell.self, forCellReuseIdentifier: StockCell.identifier)
        
        tableView.snp.makeConstraints { (maker) in
            maker.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate.numberOfStocks()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.identifier) as? StockCell {
            
            let stockViewModel = delegate.stock(atIndex: indexPath.row)
            
            cell.tickerLabel.text = stockViewModel.ticker
            cell.nameLabel.text = stockViewModel.name
            cell.priceLabel.text = "\(stockViewModel.currentPriceText)"
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        delegate.didSelect(index: indexPath.row)
    }
}
