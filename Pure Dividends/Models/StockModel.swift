//
//  StockModel.swift
//  PDNetworking
//
//  Created by Alex Bush on 6/30/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

public struct StockModel: Equatable, Codable {
    public let ticker: String
    public let name: String
    public let currentPrice: Double
    
    public init(ticker: String, name: String, currentPrice: Double) {
        self.ticker = ticker
        self.name = name
        self.currentPrice = currentPrice
    }
    
    public static func == (lhs: StockModel, rhs: StockModel) -> Bool {
        return lhs.ticker == rhs.ticker &&
        lhs.name == rhs.name &&
        lhs.currentPrice == rhs.currentPrice
    }
}
