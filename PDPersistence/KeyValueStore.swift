//
//  KeyValueStore.swift
//  PDPersistence
//
//  Created by Alex Bush on 7/4/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

protocol KeyValueStoreInterface {
    func save<T: Codable>(key: String, value: T)
    func object<T: Codable>(forKey key: String) -> T?
    func remove<T: Codable>(forKey key: String) -> T?
}

import Foundation

/** A simple key value store. Typically backed by UserDefaults. */
final class KeyValueStore: KeyValueStoreInterface {
    
    private let userDefaults: UserDefaults
    
    init(_ userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func save<T: Codable>(key: String, value: T) {
        let encoder = PropertyListEncoder()
        do {
            let encoded = try encoder.encode(value)
            userDefaults.set(encoded, forKey: key)
        } catch {
            assertionFailure()
        }
    }
    
    func object<T: Codable>(forKey key: String) -> T? {
        let decoder = PropertyListDecoder()
        if let data = userDefaults.data(forKey: key) {
            return try? decoder.decode(T.self, from: data)
        }
        return nil
    }
    
    func remove<T: Codable>(forKey key: String) -> T? {
        let objectToRemove: T? = object(forKey: key)
        userDefaults.removeObject(forKey: key)
        return objectToRemove
    }
}
