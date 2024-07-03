//
//  AuthManagerFactory.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 27.02.2023.
//

import Foundation

final class AuthManagerFactory {
    static func assembly() -> AuthManager {
        let router = Router<AuthEndPoint>()
        return AuthManagerImpl(router: router)
    }
}
