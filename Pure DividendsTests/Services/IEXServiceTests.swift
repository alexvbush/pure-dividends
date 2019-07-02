//
//  IEXServiceTests.swift
//  Pure DividendsTests
//
//  Created by Alex Bush on 6/30/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import XCTest
@testable import Pure_Dividends
import RxBlocking
import RxSwift
import PDNetworking

final class IEXClientMock: IEXClientInterface {
    
    var getPriceCallCount = 0
    
    var getPriceHandler: ((_ ticker: String) -> Observable<Double>)?
    
    func getPrice(ticker: String) -> Observable<Double> {
        getPriceCallCount += 1
        
        if let handler = getPriceHandler {
            return handler(ticker)
        }
        return Observable.just(0.0)
    }
}

final class IEXServiceTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    // MARK: - BEGING fetchPrice(forStock:)
    func test_fetchPrice_withValidTicker_returnsLatestPrice() {
        // given
        let iexClientMock = IEXClientMock()
        let tickerStub = "TEST"
        let mockPriceResult = 100.0
        iexClientMock.getPriceHandler = { ticker in
            if ticker == tickerStub {
                return Observable.just(mockPriceResult)
            } else {
                return Observable.just(0)
            }
        }
        
        let stubStock = StockModel(ticker: tickerStub, name: "company name", currentPrice: 50)
        
        let service = IEXService(client: iexClientMock)
        
        // when
        let result = service.fetchPrice(forStock: stubStock)
        // then
        XCTAssertEqual(iexClientMock.getPriceCallCount, 1)
        XCTAssertEqual(try? result.toBlocking().first()?.currentPrice, mockPriceResult)
    }
    // MARK: END fetchPrice(forStock:) -

    // MARK: - BEGING fetchPrices(forStocks:)
    func test_fetchPrices_withValidTickers_returnsLatestPrices() {
        
        // given
        let stockStub1 = StockModel(ticker: "TEST1", name: "Test 1", currentPrice: 100)
        let stockStub2 = StockModel(ticker: "TEST2", name: "Test 2", currentPrice: 100)
        let stockStub3 = StockModel(ticker: "TEST3", name: "Test 3", currentPrice: 100)
        
        let stockMock1 = StockModel(ticker: "TEST1", name: "Test 1", currentPrice: 50)
        let stockMock2 = StockModel(ticker: "TEST2", name: "Test 2", currentPrice: 150)
        let stockMock3 = StockModel(ticker: "TEST3", name: "Test 3", currentPrice: 250)
        
        let iexClientMock = IEXClientMock()
        iexClientMock.getPriceHandler = { ticker in
            switch ticker {
            case "TEST1":
                return Observable.just(50)
            case "TEST2":
                return Observable.just(150)
            case "TEST3":
                return Observable.just(250)
            default:
                return Observable.just(0)
            }
        }
        let service = IEXService(client: iexClientMock)
        // when
        let result = try? service.fetchPrices(forStocks: [stockStub1, stockStub2, stockStub3]).toBlocking().first()
        // then
        XCTAssertEqual(iexClientMock.getPriceCallCount, 3)
        XCTAssertEqual(result, [stockMock1, stockMock2, stockMock3])
    }
    // MARK: END fetchPrices(forStocks:) -
}
