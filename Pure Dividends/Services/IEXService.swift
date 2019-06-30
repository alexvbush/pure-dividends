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
}
