//
//  CompundInterstCalculatorTests.swift
//  Pure DividendsTests
//
//  Created by Alex Bush on 6/6/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import XCTest
@testable import Pure_Dividends
import Money
//import UIKit
//
//struct RUI {
//    func view(_ themable: RedditThemable) {
//
//    }
//}
//
//protocol ThemeUpdated {
//
//}
//
//protocol RedditThemable {
//    func onThemeClosure(closure: @escaping (UIView, RUI)->Void) -> Void
//}
//
//extension RedditThemable where Self: UIView {
//    func onThemeClosure(closure: @escaping (UIView, RUI) -> Void) -> Void {
//        return rui.view(self)
//    }
//}
//
//extension UIView: RedditThemable {
//    var rui: RUI {
//        return RUI()
//    }
//}
//
//UITableView().onThemeClosure { (table, theme) in
//    table.backgroundColor = .blue
//}

final class CompundInterstCalculatorTests: XCTestCase {

    override func setUp() {
      
    }
    
    // MARK: - BEGIN calculate compund interest
    func testCalculateCompundInterest_givenNumberOfYears_returnsCompundedResultWithQuarterlyFrequencyByDefault() {
        // given
        let principalDollarAmount: Money<USD> = 1000.00
        let oneYearStub: Int = 1
        let interestStub: Double = 6.00
        let calculator = CompundInterstCalculator()
        
        // when
        let result = calculator.calculateCompoundInterest(principal:principalDollarAmount,
                                                          interest: interestStub,
                                                          numberOfYears:oneYearStub)
        // then
        XCTAssertEqual(result, 1061.36)

        let twoYearsResult = calculator.calculateCompoundInterest(principal:principalDollarAmount, interest: interestStub, numberOfYears: 2)
        XCTAssertEqual(twoYearsResult, 1126.49)

        let threeYearsResult = calculator.calculateCompoundInterest(principal:principalDollarAmount, interest: interestStub, numberOfYears: 3)
        XCTAssertEqual(threeYearsResult, 1195.62)
        
        
        let tenYearsResult = calculator.calculateCompoundInterest(principal:principalDollarAmount, interest: interestStub, numberOfYears: 11)
        print(tenYearsResult)
    }
}
