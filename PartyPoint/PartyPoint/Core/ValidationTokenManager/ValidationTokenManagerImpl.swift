//
//  ValidationTokenManagerImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 28.12.2022.
//

import Foundation

final class ValidationTokenManagerImpl {
    enum ValidationTokenErrors: Error {
        case savingFaild
        case cannotRefreshToken
        case invalidData
        case noSavedTokens
    }
    
    private let keyChainManager: KeyChainMananger
    private let authManager: AuthManager
    private let accountManager: PPAccountManager
    private let decoder: PPDecoder
    private let exiperingTokenTime: TimeInterval = 900
    
    init(keyChainManager: KeyChainMananger,
         authManager: AuthManager,
         accountManager: PPAccountManager,
         decoder: PPDecoder) {
        self.keyChainManager = keyChainManager
        self.authManager = authManager
        self.accountManager = accountManager
        self.decoder = decoder
    }
}

// MARK: Private methods
private extension ValidationTokenManagerImpl {
    func validateToken(refreshToken: String) async throws -> TokenInfo {
        let refreshedToken = await authManager.updateAccessToken(refreshToken: refreshToken)
        switch refreshedToken {
        case let .success(data):
            guard let data = data,
                  let decodedTokens = decoder.parseJSON(from: data, type: PPToken.self),
                  let user = accountManager.getUser()
            else {
                throw ValidationTokenErrors.invalidData
            }
            
            let expiringTime = Date().addingTimeInterval(exiperingTokenTime)
            let tokenInfo = TokenInfo(tokens: decodedTokens, expireDate: expiringTime)
            
            do {
                try keyChainManager.save(tokenInfo, service: PPToken.kTokensKeyChain, account: user.email)
            } catch {
                throw ValidationTokenErrors.savingFaild
            }
            return tokenInfo
        case let .failure(reason):
            debugPrint(reason ?? "")
            throw ValidationTokenErrors.cannotRefreshToken
        }
    }
}

// MARK: ValidationTokenManager
extension ValidationTokenManagerImpl: ValidationTokenManager {
    func saveTokens(_ tokens: PPToken) throws {
        do {
            guard let user = accountManager.getUser() else {
                throw ValidationTokenErrors.savingFaild
            }
            let expireDate = Date().addingTimeInterval(exiperingTokenTime)
            let tokenInfo = TokenInfo(tokens: tokens, expireDate: expireDate)
            
            try keyChainManager.save(tokenInfo,
                                     service: PPToken.kTokensKeyChain,
                                     account: user.email)
        } catch {
            throw error
        }
    }
    
    func getAccessToken() async throws -> String {
        guard let user = accountManager.getUser(),
              let token = keyChainManager.read(service: PPToken.kTokensKeyChain,
                                               account: user.email,
                                               type: TokenInfo.self)
        else {
            throw ValidationTokenErrors.noSavedTokens
        }

        if token.isValid {
            return token.accessToken
        } else {
            do {
                let tokenInfo = try await validateToken(refreshToken: token.refreshToken)
                return tokenInfo.accessToken
            } catch ValidationTokenErrors.invalidData {
                throw ValidationTokenErrors.invalidData
            } catch ValidationTokenErrors.savingFaild {
                throw ValidationTokenErrors.savingFaild
            } catch ValidationTokenErrors.cannotRefreshToken {
                throw ValidationTokenErrors.cannotRefreshToken
            } catch {
                throw error
            }
        }
    }
}
