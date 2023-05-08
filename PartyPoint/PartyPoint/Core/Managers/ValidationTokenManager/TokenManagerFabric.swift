//
//  TokenManagerFabric.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 27.02.2023.
//

import Foundation

final class TokenManagerFabric {
    static func assembly() -> ValidationTokenManager {
        let keychainManager = KeyChainManangerImpl()
        let networkRouter = Router<AuthEndPoint>()
        let authManager = AuthManagerImpl(router: networkRouter)
        let decoder = PPDecoderImpl()
        let accountManager = AccountManangerFabric.assembly()
        return ValidationTokenManagerImpl(keyChainManager: keychainManager,
                                          authManager: authManager,
                                          accountManager: accountManager,
                                          decoder: decoder)
    }
}
