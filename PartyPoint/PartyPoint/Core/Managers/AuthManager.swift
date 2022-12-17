//
//  AuthManager.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.11.2022.
//

import Foundation

enum AuthStatus {
    case authorized
    case nonAuthoraized(error: String)
}

protocol AuthManager {
    func login(with login: String, password: String) async -> AuthStatus
    func register(with name: String, surname: String, mail: String, password: String) async -> NetworkManager.ResponseResult
}

final class AuthManagerImpl: NetworkManager, AuthManager {
    private let router: Router<AuthEndPoint>
    
    init(router: Router<AuthEndPoint>) {
        self.router = router
    }
    
    func login(with login: String, password: String) async -> AuthStatus {
        let result = await router.request(.login(email: login, passwd: password))
        
        let httpResponse = result.response as? HTTPURLResponse
        let status = handleNetworkResponse(httpResponse)
        
        switch status {
        case .success:
            return .authorized
        case let .failure(error):
            return .nonAuthoraized(error: error)
        }
    }
    
    func register(with name: String, surname: String, mail: String, password: String) async -> ResponseResult {
        let result = await router.request(.signUp(email: mail, name: name, passwd: password, surname: surname))
         
        let httpResponse = result.response as? HTTPURLResponse
        let status = handleNetworkResponse(httpResponse)
        
        switch status {
        case .success:
            return .success
        case let .failure(error):
            return .failure(error)
        }
    }
    
    func logout() {}
}
