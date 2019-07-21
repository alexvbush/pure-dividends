//
//  StocksStore.swift
//  Pure Dividends
//
//  Created by Alex Bush on 7/20/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import PDPersistence

protocol StocksStorageInterface {
    func retriveMainPortfolio() -> [StockModel]
}

final class StocksStorage: StocksStorageInterface {
    
    private let keyValueStore: KeyValueStoreInterface
    
    init(keyValueStore: KeyValueStoreInterface) {
        self.keyValueStore = keyValueStore
    }
    
    func retriveMainPortfolio() -> [StockModel] {
        return [StockModel(ticker: "T", name: "AT&T", currentPrice: 30.58),
                StockModel(ticker: "MSFT", name: "Microsoft", currentPrice: 124.12),
                StockModel(ticker: "SQ", name: "Square", currentPrice: 60.5),
                StockModel(ticker: "SPY", name: "SPY", currentPrice: 230.78),
                StockModel(ticker: "TLT", name: "iShares 20+ Year Treasury Bond ETF", currentPrice: 131.83)]
    }
}
