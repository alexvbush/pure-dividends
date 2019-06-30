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

}
