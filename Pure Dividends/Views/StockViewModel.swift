//
//  StockViewModel.swift
//  Pure Dividends
//
//  Created by Alex Bush on 6/29/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

struct StockViewModel {
    let stock: StockModel
    
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
