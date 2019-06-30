//
//  CurrentUserManager.swift
//  Pure Dividends
//
//  Created by Alex Bush on 6/29/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

protocol SessionManagerInterface {
    func save(session: Session)
    func currentSession() -> Session?
    func clearSession()
}

final class SessionManager: SessionManagerInterface {
    
    private var session: Session?
    
    func save(session: Session) {
        self.session = session
    }
    
    func currentSession() -> Session? {
        return session
    }
    
    func clearSession() {
        session = nil
    }
}
