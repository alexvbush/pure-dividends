//
//  IEXService.swift
//  Pure Dividends
//
//  Created by Alex Bush on 6/30/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import PDNetworking
import RxSwift

protocol IEXServiceInterface {
    func fetchPrice(forStock stock: StockModel) -> Observable<StockModel>
    func fetchPrices(forStocks stocks: [StockModel]) -> Observable<[StockModel]>
    func fetchStockQuote(_ stock: StockModel) -> Observable<StockQuoteModel>
    func search(ticker: String) -> Observable<[TickerSearchResultItem]>
}

final class IEXService: IEXServiceInterface {
    
    private let iexClient: IEXClientInterface
    
    init(client: IEXClientInterface) {
        self.iexClient = client
    }
    
    func fetchPrice(forStock stock: StockModel) -> Observable<StockModel> {        
        return iexClient.getPrice(ticker: stock.ticker).map { (newPrice) -> StockModel in
            return StockModel(ticker: stock.ticker, name: stock.name, currentPrice: newPrice)
        }
    }
    
    func fetchPrices(forStocks stocks: [StockModel]) -> Observable<[StockModel]> {        
        return Observable.from(stocks).flatMap { (stock) -> Observable<StockModel> in
            return self.fetchPrice(forStock: stock)
        }.reduce([], accumulator: { (newStocks, stockModel) -> [StockModel] in
            return newStocks + [stockModel]
        })
    }
    
    func fetchStockQuote(_ stock: StockModel) -> Observable<StockQuoteModel> {
        
        return iexClient.getQuote(ticker: stock.ticker).map { (stockQuoteDictionary) -> StockQuoteModel in
            let stockQuoteModel = StockQuoteModel(ticker: stock.ticker,
                                                  open: stockQuoteDictionary["open"] as? Double ?? 0.0,
                                                  close: stockQuoteDictionary["close"] as? Double ?? 0.0,
                                                  high: stockQuoteDictionary["high"] as? Double ?? 0.0,
                                                  low: stockQuoteDictionary["low"] as? Double ?? 0.0)
            return stockQuoteModel
        }                
    }
    
    func search(ticker: String) -> Observable<[TickerSearchResultItem]> {
        return iexClient.getSearch(ticker: ticker).map { (tickersSearchResultJSONArray) -> [TickerSearchResultItem] in
            return tickersSearchResultJSONArray.compactMap { (tickerSearchResultJSON) -> TickerSearchResultItem in
                return TickerSearchResultItem(symbol: tickerSearchResultJSON["symbol"] ?? "",
                                              name: tickerSearchResultJSON["symbol"] ?? "")
            }
        }
    }
}
