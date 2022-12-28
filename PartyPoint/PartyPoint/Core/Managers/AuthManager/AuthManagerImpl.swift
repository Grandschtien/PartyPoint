//
//  AuthManagerImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 28.12.2022.
//

import Foundation

final class AuthManagerImpl: NetworkManager, AuthManager {
    
    enum AuthStatus {
        //String - распаршеный токен
        case authorized(data: Data?)
        case nonAuthoraized(reason: String?)
    }
    
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
            return .authorized(data: result.data)
        case let .failure(reason):
            return .nonAuthoraized(reason: reason)
        }
    }
    
    func register(with name: String, surname: String, mail: String, password: String) async -> AuthStatus {
        let result = await router.request(.signUp(email: mail, name: name, passwd: password, surname: surname))
         
        let httpResponse = result.response as? HTTPURLResponse
        let status = handleNetworkResponse(httpResponse)

        switch status {
        case .success:
            return .authorized(data: result.data)
        case let .failure(reason):
            return .nonAuthoraized(reason: reason)
        }
    }
    
    func logout() {}
}
