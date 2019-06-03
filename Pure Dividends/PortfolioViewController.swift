//
//  PortfolioViewController.swift
//  Pure Dividends
//
//  Created by Alex Bush on 5/31/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import UIKit
import Alamofire
import RxAlamofire
import RxSwift

private struct StockModel {
    let ticker: String
    let name: String
    let currentPrice: Double
}

private struct StockViewModel {
    private let stock: StockModel
    
    init(stock: StockModel) {
        self.stock = stock
    }
    
    var ticker: String {
        return stock.ticker
    }
    
    var name: String {
        return stock.name
    }
    
    var currentPriceText: String {
        return "$\((stock.currentPrice * 100).rounded(.toNearestOrEven) / 100)"
    }
}

class StockCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
}

final class PortfolioViewController: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    private let manager = SessionManager.default
    
    private var stocksModels = [StockModel(ticker: "T", name: "AT&T", currentPrice: 30.58),
                                    StockModel(ticker: "MSFT", name: "Microsoft", currentPrice: 124.12),
                                    StockModel(ticker: "SQ", name: "Square", currentPrice: 60.5),
                                    StockModel(ticker: "SPY", name: "SPY", currentPrice: 230.78),
                                    StockModel(ticker: "TLT", name: "iShares 20+ Year Treasury Bond ETF", currentPrice: 131.83)]
    
    private var stocksViewModels: [StockViewModel] {
        return stocksModels.map { StockViewModel(stock: $0) }
        
//        return stocksModels.map { StockViewModel(stock: $0) }.sorted(by: { (stockVM1, stockVM2) -> Bool in
//            return stockVM1.ticker > stockVM2.ticker
//        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _ = Observable.from(stocksModels).flatMap { stockModel -> Observable<(StockModel, Any)> in
            let url = URL(string: "https://sandbox.iexapis.com/v1/stock/\(stockModel.ticker)/price?token=Tsk_5b6a7d4e02db464b9447f498407d78f4")!
            return Observable.combineLatest(Observable.just(stockModel), self.manager.rx.json(.get, url))
        }.map { model, response -> StockModel in
            let newCurrentPrice = response as! Double
            let newStockModel = StockModel(ticker: model.ticker, name: model.name, currentPrice: newCurrentPrice)
            return newStockModel
        }.reduce([], accumulator: { (newStocks, stockModel) -> [StockModel] in
            return newStocks + [stockModel]
        }).subscribe(onNext: { (newStockModels) in
            self.stocksModels = newStockModels
            self.tableView.reloadData()
        }, onError: { (error) in
            print("error: \(error)")
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocksViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "portfolio-cell-id") as? StockCell {
            
            let stockViewModel = stocksViewModels[indexPath.row]
            
            cell.nameLabel.text = stockViewModel.name
            cell.priceLabel.text = "\(stockViewModel.currentPriceText)"

            return cell
        }
        return UITableViewCell()
    }
}
