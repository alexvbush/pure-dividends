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
    
    private var stocksModels = [StockModel(ticker: "T", name: "AT&T", currentPrice: 30.58),
                                StockModel(ticker: "MSFT", name: "Microsoft", currentPrice: 124.12),
                                StockModel(ticker: "SQ", name: "Square", currentPrice: 60.5),
                                StockModel(ticker: "SPY", name: "SPY", currentPrice: 230.78),
                                StockModel(ticker: "TLT", name: "iShares 20+ Year Treasury Bond ETF", currentPrice: 131.83)]

    override init(presenter: PortfolioPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        presenter.present(stocks: stocksModels)
    }
}
