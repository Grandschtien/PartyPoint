//
//  UserDefaultsManagerImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 01.02.2023.
//

import Foundation

private let kIsLogged = "kIsLogged"

public final class UserDefaultsManagerImpl {
    private let storage: KeyValueStorage
    
    public init(storage: KeyValueStorage) {
        self.storage = storage
    }
}

extension UserDefaultsManagerImpl: UserDefaultsManager {
    public func setIsLogged(_ flag: Bool) {
        storage.setValue(flag, forKey: kIsLogged)
    }
    
    public func getIsLogged() -> Bool {
        guard let isLogged = storage.getValue(forkey: kIsLogged, ofType: Bool.self) else { return false }
        return isLogged
    }
    
    public func removeIsLogged() {
        storage.removeValue(forkey: kIsLogged)
    }
}
