//
//  PPAccountManagerImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 02.01.2023.
//

import Foundation

final class PPAccountManagerImpl {
    private let storage: KeyValueStorage = UserDefaults.standard
    private let decoder: PPDecoder
    private let kCurrentUser = "current_user"
    
    init(decoder: PPDecoder) {
        self.decoder = decoder
    }
}

// MARK: PPAccountManager
extension PPAccountManagerImpl: PPAccountManager {
    func setUser(user: PPUserInformation) {
        storage.setValue(user, forKey: kCurrentUser)
    }
    
    func removeUser() {
        storage.removeValue(forkey: kCurrentUser)
    }
    
    func getUser() -> PPUserInformation? {
        return storage.getValue(forkey: kCurrentUser, ofType: PPUserInformation.self)
    }
    
    func parseUserInformation(data: Data?) -> PPUser? {
        guard let data = data else { return nil }
        let userInfo = decoder.parseJSON(from: data, type: PPUser.self)
        return userInfo
    }
}
