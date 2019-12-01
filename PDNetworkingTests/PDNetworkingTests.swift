//
//  PDNetworkingTests.swift
//  PDNetworkingTests
//
//  Created by Alex Bush on 6/30/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import XCTest
@testable import PDNetworking
import Alamofire

class PDNetworkingTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetPrice() {
        
        let expectation = XCTestExpectation()
        
        let client = IEXClient(manager: SessionManager.default)
        let _ = client.getPrice(ticker: "MSFT").subscribe(onNext: { (newPrice) in
            print("new price: \(newPrice)")
            expectation.fulfill()
        }, onError: { (error) in
            print("error: \(error)")
        })
        
        wait(for: [expectation], timeout: 2)
    }

    func testGetEarnings() {
        let expectation = XCTestExpectation()
        
        let client = IEXClient(manager: SessionManager.default)
        let _ = client.getEarnings(ticker: "AAPL").subscribe(onNext: { (newPrice) in
            print("new price: \(newPrice)")
            expectation.fulfill()
        }, onError: { (error) in
            print("error: \(error)")
        })
        
        wait(for: [expectation], timeout: 2)
    }
}
