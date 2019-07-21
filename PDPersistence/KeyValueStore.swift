//
//  KeyValueStore.swift
//  PDPersistence
//
//  Created by Alex Bush on 7/4/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

public protocol KeyValueStoreInterface {
    func save<T: Codable>(key: String, value: T)
    func object<T: Codable>(forKey key: String) -> T?
    func remove<T: Codable>(forKey key: String) -> T?
}

import Foundation

/** A simple key value store. Typically backed by UserDefaults. */
public final class KeyValueStore: KeyValueStoreInterface {
    
    private let userDefaults: UserDefaults
    
    public init(_ userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    public func save<T: Codable>(key: String, value: T) {
        let encoder = PropertyListEncoder()
        do {
            let encoded = try encoder.encode(value)
            userDefaults.set(encoded, forKey: key)
        } catch {
            assertionFailure()
        }
    }
    
    public func object<T: Codable>(forKey key: String) -> T? {
        let decoder = PropertyListDecoder()
        if let data = userDefaults.data(forKey: key) {
            return try? decoder.decode(T.self, from: data)
        }
        return nil
    }
    
    public func remove<T: Codable>(forKey key: String) -> T? {
        let objectToRemove: T? = object(forKey: key)
        userDefaults.removeObject(forKey: key)
        return objectToRemove
    }
}
