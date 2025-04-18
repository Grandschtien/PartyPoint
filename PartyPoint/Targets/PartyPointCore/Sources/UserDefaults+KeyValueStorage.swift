//
//  UserDefaults+Storage.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 02.01.2023.
//

import Foundation

public protocol KeyValueStorage {
    func setValue<T: Codable>(_ object: T, forKey key: String)
    func getValue<T: Codable>(forkey key: String, ofType type: T.Type) -> T?
    func removeValue(forkey key: String)
}

extension UserDefaults: KeyValueStorage {
    public func setValue<T: Codable>(_ object: T, forKey key: String) {
        let encoded = try? JSONEncoder().encode(object)
        self.set(encoded, forKey: key)
    }
    
    public func getValue<T: Codable>(forkey key: String, ofType type: T.Type) -> T? {
        guard let value = self.value(forKey: key) as? Data else { return nil }
        let decoded = try? JSONDecoder().decode(type.self, from: value)
        return decoded
    }
    
    public func removeValue(forkey key: String) {
        self.removeObject(forKey: key)
    }
}
