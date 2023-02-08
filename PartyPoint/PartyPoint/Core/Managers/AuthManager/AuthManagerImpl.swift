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
    
    enum RefreshTokenStatus {
        case success(data: Data?)
        case failure(reason: String?)
    }
    
    private let router: Router<AuthEndPoint>
    
    init(router: Router<AuthEndPoint>) {
        self.router = router
    }
    
    func updateAccessToken(refreshToken: String) async -> RefreshTokenStatus {
        let result = await router.request(.refresh(refreshToken: refreshToken))
        
        switch getStatus(response: result.response) {
        case .success:
            return .success(data: result.data)
        case let .failure(reason):
            return .failure(reason: reason)
        }
    }
    
    func login(with login: String, password: String) async -> AuthStatus {
        let result = await router.request(.login(email: login, passwd: password))
        
        switch getStatus(response: result.response) {
        case .success:
            return .authorized(data: result.data)
        case let .failure(reason):
            return .nonAuthoraized(reason: reason)
        }
    }
    
    func register(with info: PPRegisterUserInformation) async -> AuthStatus {
        let result = await router.request(.signUp(name: info.name,
                                                        surname: info.surname,
                                                        email: info.email,
                                                        passwd: info.passwd,
                                                        dateOfBirth: info.dateOfBirth,
                                                        image: info.imageData))

        switch getStatus(response: result.response) {
        case .success:
            return .authorized(data: result.data)
        case let .failure(reason):
            return .nonAuthoraized(reason: reason)
        }
    }
    
    func logout() {}
}
