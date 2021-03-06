//
//  PortfolioInteractor.swift
//  Pure Dividends
//
//  Created by Alex Bush on 6/29/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs
import RxSwift

protocol PortfolioListRouting: ViewableRouting {
    func routeToStockDetals(_ stock: StockModel)
    func routeAwayFromStockDetals()
    func routeToAddStock()
    func routeAwayFromAddStock()
}

protocol PortfolioListPresentable: Presentable {
    var listener: PortfolioListPresentableListener? { get set }
    
    func present(stocks: [StockModel])
}

protocol PortfolioListListener: class {}

final class PortfolioListInteractor: PresentableInteractor<PortfolioListPresentable>, PortfolioListInteractable, PortfolioListPresentableListener {

    weak var router: PortfolioListRouting?
    weak var listener: PortfolioListListener?
    
    private let iexService: IEXServiceInterface
    
    private var stockModels = [StockModel]()
    
    private let stocksStorage: StocksStorageInterface

    init(presenter: PortfolioListPresentable,
         iexService: IEXServiceInterface,
         stocksStorage: StocksStorageInterface) {
        self.iexService = iexService
        self.stocksStorage = stocksStorage
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        stockModels = stocksStorage.retriveMainPortfolio()
        
        presenter.present(stocks: stockModels)
        
        fetchLatestPrices()
    }
    
    private func fetchLatestPrices() {
        iexService.fetchPrices(forStocks: stockModels).subscribe(onNext: { (updateStockModels) in
            self.stockModels = updateStockModels
            self.presenter.present(stocks: updateStockModels)
        }, onError: { (error) in
            print("error: \(error)")
        }).disposeOnDeactivate(interactor: self)
    }
    
    func stockSelected(_ stock: StockModel) {
        router?.routeToStockDetals(stock)
    }
    
    func addStockSelected() {
        router?.routeToAddStock()
    }
}

extension PortfolioListInteractor: StockDetailsListener {
    func didComplete(_ interactor: StockDetailsInteractable) {
        router?.routeAwayFromStockDetals()
    }
}

extension PortfolioListInteractor: AddStockListener {
    func didComplete(_ interactor: AddStockInteractable) {
        router?.routeAwayFromAddStock()
    }
    
    func didComplete(_ interactor: AddStockInteractable, withSelectedTickerToAdd selectedTicker: TickerSearchResultItem) {
        let newStock = StockModel(ticker: selectedTicker.symbol, name: selectedTicker.name, currentPrice: 0.0)
        stocksStorage.saveStock(stock: newStock)
        
        stockModels = stocksStorage.retriveMainPortfolio()        
        fetchLatestPrices()
        
        router?.routeAwayFromAddStock()
    }
}
