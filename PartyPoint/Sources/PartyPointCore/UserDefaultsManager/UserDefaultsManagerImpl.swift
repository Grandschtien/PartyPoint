//
//  UserDefaultsManagerImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 01.02.2023.
//

import Foundation

private let kIsLogged = "kIsLogged"

final class UserDefaultsManagerImpl {
    private let storage: KeyValueStorage
    
    init(storage: KeyValueStorage) {
        self.storage = storage
    }
}

extension UserDefaultsManagerImpl: UserDefaultsManager {
    func setIsLogged(_ flag: Bool) {
        storage.setValue(flag, forKey: kIsLogged)
    }
    
    func getIsLogged() -> Bool {
        guard let isLogged = storage.getValue(forkey: kIsLogged, ofType: Bool.self) else { return false }
        return isLogged
    }
    
    func removeIsLogged() {
        storage.removeValue(forkey: kIsLogged)
    }
}
