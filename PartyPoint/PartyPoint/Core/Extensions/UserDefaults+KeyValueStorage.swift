//
//  UserDefaults+Storage.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 02.01.2023.
//

import Foundation

protocol KeyValueStorage {
    func setValue<T: Codable>(_ object: T, forKey key: String)
    func getValue<T: Codable>(forkey key: String, ofType type: T.Type) -> T?
}

extension UserDefaults: KeyValueStorage {
    func setValue<T: Codable>(_ object: T, forKey key: String) {
        let encoded = try? JSONEncoder().encode(object)
        self.set(encoded, forKey: key)
    }
    
    func getValue<T: Codable>(forkey key: String, ofType type: T.Type) -> T? {
        guard let value = self.value(forKey: key) as? Data else { return nil }
        let decoded = try? JSONDecoder().decode(type.self, from: value)
        return decoded
    }
}
