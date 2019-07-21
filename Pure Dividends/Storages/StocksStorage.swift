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
    
    func saveStock(stock: StockModel)
}

final class StocksStorage: StocksStorageInterface {
    
    private static let kStocksStorageKey = "kStocksStorageKey"
    
    private let keyValueStore: KeyValueStoreInterface
    
    init(keyValueStore: KeyValueStoreInterface) {
        self.keyValueStore = keyValueStore
    }
    
    func retriveMainPortfolio() -> [StockModel] {
        
        if let stocks: [StockModel] = keyValueStore.object(forKey: StocksStorage.kStocksStorageKey) {
            return stocks
        } else {
            return []
        }
        
//        return [StockModel(ticker: "T", name: "AT&T", currentPrice: 30.58),
//                StockModel(ticker: "MSFT", name: "Microsoft", currentPrice: 124.12),
//                StockModel(ticker: "SQ", name: "Square", currentPrice: 60.5),
//                StockModel(ticker: "SPY", name: "SPY", currentPrice: 230.78),
//                StockModel(ticker: "TLT", name: "iShares 20+ Year Treasury Bond ETF", currentPrice: 131.83)]
    }
    
    func saveStock(stock: StockModel) {
        let stocks: [StockModel]? = keyValueStore.object(forKey: StocksStorage.kStocksStorageKey)
        
        if let stocks = stocks {
            let newStocks = stocks + [stock]
            keyValueStore.save(key: StocksStorage.kStocksStorageKey, value: newStocks)
        } else {
            let newStocks = [stock]
            keyValueStore.save(key: StocksStorage.kStocksStorageKey, value: newStocks)
        }
    }
}
