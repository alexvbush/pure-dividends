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

protocol PortfolioPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class PortfolioViewController: UIViewController, PortfolioPresentable, PortfolioViewControllable, PortfolioViewDelegate {

    weak var listener: PortfolioPresentableListener?
    
    private lazy var internalView = PortfolioView(delegate: self)
    
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
    // MARK: END PortfolioViewDelegate -
}

fileprivate protocol PortfolioViewDelegate {
    func numberOfStocks() -> Int
    func stock(atIndex index: Int) -> StockViewModel
}

fileprivate final class PortfolioView: UIView, UITableViewDelegate, UITableViewDataSource {
    private let delegate: PortfolioViewDelegate
    
    private let tableView: UITableView
    
    init(delegate: PortfolioViewDelegate) {
        self.delegate = delegate
        self.tableView = UITableView()
        super.init(frame: .zero)
        
        backgroundColor = .purple
        
        setupTableView()
        
//        tableView.reloadData()
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
}
