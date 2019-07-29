//
//  StockQuoteModel.swift
//  Pure Dividends
//
//  Created by Alex Bush on 7/27/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

struct StockQuoteModel: Equatable, Codable {
    
    let ticker: String
    let open: Double
    let close: Double
    let high: Double
    let low: Double
    
    public init(ticker: String,
                open: Double,
                close: Double,
                high: Double,
                low: Double) {
        self.ticker = ticker
        self.open = open
        self.close = close
        self.high = high
        self.low = low
    }
    
    public static func == (lhs: StockQuoteModel, rhs: StockQuoteModel) -> Bool {
        return lhs.ticker == rhs.ticker &&
            lhs.open == rhs.open &&
            lhs.close == rhs.close &&
            lhs.high == rhs.high &&
            lhs.low == rhs.low
    }
}
