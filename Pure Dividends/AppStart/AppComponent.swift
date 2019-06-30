//
//  AppComponent.swift
//  Pure Dividends
//
//  Created by Alex Bush on 6/21/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import Foundation
import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {
    
    init() {
        super.init(dependency: EmptyComponent())
    }
    
    var sessionManager: SessionManagerInterface {
        let sessionManager = SessionManager()
        sessionManager.save(session: Session(token: "jslfdhk"))
        return sessionManager
    }
}
