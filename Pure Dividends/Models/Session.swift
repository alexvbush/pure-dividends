//
//  Session.swift
//  Pure Dividends
//
//  Created by Alex Bush on 6/29/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

struct Session: Equatable {
        
    let token: String
    
    static func == (lhs: Session, rhs: Session) -> Bool {
        return lhs.token == rhs.token
    }
}
