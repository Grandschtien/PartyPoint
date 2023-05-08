//
//  PPAccountManagerImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 02.01.2023.
//

import Foundation

final class PPAccountManagerImpl: NetworkManager {
    private let storage: KeyValueStorage = UserDefaults.standard
    private let decoder: PPDecoder
    private let kCurrentUser = "current_user"
    private let router: Router<UserEndPoint>
    
    init(decoder: PPDecoder, router: Router<UserEndPoint>) {
        self.decoder = decoder
        self.router = router
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
    
    func changePassword(token: String, password: String) async -> DefaultResultOfRequest {
        let result = await router.request(.changePassword(token: token, passwd: password))
        switch getStatus(response: result.response) {
        case .success:
            return .success(result.data)
        case let .failure(reason):
            return .failure(reason)
        }
    }
}
