//
//  PDPersistenceTests.swift
//  PDPersistenceTests
//
//  Created by Alex Bush on 7/4/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import XCTest
@testable import PDPersistence

struct TestStruct: Codable, Equatable {
    let string: String
    
    static func == (lhs: TestStruct, rhs: TestStruct) -> Bool {
        return lhs.string == rhs.string
    }
}

final class KeyValueStoreTests: XCTestCase {
    
    private var store: KeyValueStoreInterface!
    private let userDefaults = UserDefaults()
    
    override func setUp() {
        super.setUp()
        store = KeyValueStore(userDefaults)
    }
    
    override func tearDown() {
        for key in userDefaults.dictionaryRepresentation().keys {
            userDefaults.removeObject(forKey: key)
        }
        
        super.tearDown()
    }
    
    func testSaveDictionary() {
        // given
        let key = "unitTestKey"
        let value = ["unitTestDictKey":"unitTestDictValue"]
        // when
        store.save(key: key, value: value)
        // then
        let result = store.object(forKey: key) ?? ["":""]
        XCTAssertEqual(result, value)
    }
    
    func testSaveCustomObject() throws {
        // given
        let key = "unitTestKey"
        let value = TestStruct(string: "text")
        // when
        store.save(key: key, value: value)
        // then
        let result: TestStruct? = store.object(forKey: key)
        XCTAssertEqual(result, value)
        let unequalSession = TestStruct(string: "other text")
        XCTAssertNotEqual(result, unequalSession)
    }
    
    func testRetrieveValueNotSaved() throws {
        // given
        let unusedKey = "unitTestUnusedKey"
        // when
        let result: String? = store.object(forKey: unusedKey)
        // then
        XCTAssertNil(result)
    }
    
    func testRemoveObjectForKey() {
        // given
        let keyStub = "unitTestKey"
        let valueMock = TestStruct(string: "abc")
        store.save(key: keyStub, value: valueMock)
        // when
        let result: TestStruct? = store.remove(forKey: keyStub)
        // then
        XCTAssertEqual(result, valueMock)
        let storedObject: TestStruct? = store.object(forKey: keyStub)
        XCTAssertNil(storedObject)
    }
}

