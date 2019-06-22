//
//  CompundInterstCalculator.swift
//  Pure Dividends
//
//  Created by Alex Bush on 6/6/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import Foundation
import Money

enum CompoundingFrequency: Int {
    case annually = 1
    case semiannually = 2
    case quarterly = 4
}

final class CompundInterstCalculator {
    
    func calculateCompoundInterest(principal: Money<USD>, interest: Double, numberOfYears: Int, compoundingFrequency: CompoundingFrequency = .quarterly) -> Money<USD> {
        
        let numberOfCompoundEvents = numberOfYears * compoundingFrequency.rawValue
        let interestPerCompoundEvent = interest / Double(compoundingFrequency.rawValue) / Double(100)

        var compoundedCapital = principal

        for _ in 1...numberOfCompoundEvents {
            let interstEarned = compoundedCapital * interestPerCompoundEvent
            compoundedCapital += interstEarned
        }

        return compoundedCapital
    }
}
