//
//  PortfolioInteractor.swift
//  Pure Dividends
//
//  Created by Alex Bush on 6/29/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs
import RxSwift

protocol PortfolioRouting: ViewableRouting {}

protocol PortfolioPresentable: Presentable {
    var listener: PortfolioPresentableListener? { get set }
    
    func present(stocks: [StockModel])
}

protocol PortfolioListener: class {}

final class PortfolioInteractor: PresentableInteractor<PortfolioPresentable>, PortfolioInteractable, PortfolioPresentableListener {

    weak var router: PortfolioRouting?
    weak var listener: PortfolioListener?
    
    private let iexService: IEXServiceInterface
    
    private var stockModels = [StockModel]()
    
    private let stocksStorage: StocksStorageInterface

    init(presenter: PortfolioPresentable,
         iexService: IEXServiceInterface,
         stocksStorage: StocksStorageInterface) {
        self.iexService = iexService
        self.stocksStorage = stocksStorage
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
//        stocksStorage.saveStock(stock: StockModel(ticker: "T", name: "AT&T", currentPrice: 30.58))
        
        stockModels = stocksStorage.retriveMainPortfolio()
        
        presenter.present(stocks: stockModels)
        
        iexService.fetchPrices(forStocks: stockModels).subscribe(onNext: { (updateStockModels) in
            self.stockModels = updateStockModels
            self.presenter.present(stocks: updateStockModels)
        }, onError: { (error) in
            print("error: \(error)")
        }).disposeOnDeactivate(interactor: self)

    }
}
