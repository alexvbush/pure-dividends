//
//  CurrentUserManagerTests.swift
//  Pure DividendsTests
//
//  Created by Alex Bush on 6/29/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import XCTest
@testable import Pure_Dividends

final class SessionManagerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    // MARK: - BEGIN saveSession()
    func test_saveSession_savesGivenSession() {
        // given
        let sessionMock = Session(token: "hfjdks")
        let manager = SessionManager()
        // when
        manager.save(session: sessionMock)
        // then
        XCTAssertNotNil(manager.currentSession())
        XCTAssertEqual(manager.currentSession(), sessionMock)
    }
    // MARK: END -
    
    // MARK: - BEGIN clearSession()
    func test_clearSession_removesSavedSession() {
        // given
        let sessionMock = Session(token: "hfjdks")
        let manager = SessionManager()
        manager.save(session: sessionMock)
        // when
        manager.clearSession()
        // then
        XCTAssertNil(manager.currentSession())        
    }
    // MARK: END -
}
