//
//  AuthManagerImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 28.12.2022.
//

import Foundation

final class AuthManagerImpl: NetworkManager, AuthManager {
    private let router: Router<AuthEndPoint>
    
    init(router: Router<AuthEndPoint>) {
        self.router = router
    }
    
    func updateAccessToken(refreshToken: String) async -> DefaultResultOfRequest {
        let result = await router.request(.refresh(refreshToken: refreshToken))
        
        switch getStatus(response: result.response) {
        case .success:
            return .success(result.data)
        case let .failure(reason):
            return .failure(reason)
        }
    }
    
    func login(with login: String, password: String) async -> DefaultResultOfRequest {
        let result = await router.request(.login(email: login, passwd: password))
        
        switch getStatus(response: result.response) {
        case .success:
            return .success(result.data)
        case let .failure(reason):
            return .failure(reason)
        }
    }
    
    func register(with info: PPRegisterUserInformation) async -> DefaultResultOfRequest {
        let result = await router.request(.signUp(name: info.name,
                                                        surname: info.surname,
                                                        email: info.email,
                                                        passwd: info.passwd,
                                                        dateOfBirth: info.dateOfBirth,
                                                        image: info.imageData))

        switch getStatus(response: result.response) {
        case .success:
            return .success(result.data)
        case let .failure(reason):
            return .failure(reason)
        }
    }
    
    // MARK: Restore password flow
    func sendCofirmCode(toEmail email: String) async -> DefaultResultOfRequest {
        let result = await router.request(.sendCode(email: email))
        switch getStatus(response: result.response) {
        case .success:
            return .success(result.data)
        case let .failure(reason):
            return .failure(reason)
        }
    }
    
    func checkConfirmCode(email: String, code: Int) async -> DefaultResultOfRequest {
        let result = await router.request(.checkConfirmationCode(code: code, email: email))
        switch getStatus(response: result.response) {
        case .success:
            return .success(result.data)
        case let .failure(reason):
            return .failure(reason)
        }
    }
    
    func sendNewPassword(email: String, password: String) async -> DefaultResultOfRequest {
        let result = await router.request(.credentials(email: email, passwd: password))
        switch getStatus(response: result.response) {
        case .success:
            return .success(result.data)
        case let .failure(reason):
            return .failure(reason)
        }
    }
    
    func logout(accessToken: String, refreshToken: String) async -> DefaultResultOfRequest {
        let result = await router.request(.logout(accessToken: accessToken, refreshToken: refreshToken))
        switch getStatus(response: result.response) {
        case .success:
            return .success(nil)
        case let .failure(reason):
            return .failure(reason)
        }
    }
}
