//
//  CompoundCalculatorTests.swift
//  Pure DividendsTests
//
//  Created by Alex Bush on 8/16/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import XCTest
@testable import Pure_Dividends
import Darwin

final class CompoundCalculatorTests: XCTestCase {
    
    func testExample() {
        // given
        let p: Double = 100000
        let r: Double = 0.02
        let n: Double = 4
        let t: Double = 35
        
//        https://github.com/attaswift/BigInt
        
        // when
        print(p * (1 + r/n))
        print((n * t))
        let first = p * (1 + r/n)
        let second = (n * t)
        print(Int(first) << (Int(second) - 1))
        let result = pow(p * (1 + r/n), (n * t))
        
        // then
        XCTAssertEqual(result, 20102434)
    }
}
