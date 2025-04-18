//
//  ValidationTokenManagerImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 28.12.2022.
//

import Foundation
import PartyPointCore

enum ValidationTokenErrors: Error {
    case savingFaild
    case cannotRefreshToken
    case invalidData
    case noSavedTokens
}

final class ValidationTokenManagerImpl {
    private let keyChainManager: KeyChainMananger
    private let authManager: AuthManager
    private let accountManager: PPAccountManager
    private let decoder: PPDecoder
    private let exiperingTokenTime: TimeInterval = 900
    private let expireRefreshTokenTime: TimeInterval = 30 * 24 * 60 * 60
    
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
                  let decodedTokens = decoder.parseJSON(from: data, type: PPToken.self)
            else {
                throw ValidationTokenErrors.invalidData
            }
            do {
                try saveTokens(decodedTokens)
            } catch {
                throw ValidationTokenErrors.savingFaild
            }
            return TokenInfo(tokens: decodedTokens,
                             expireDate: Date().addingTimeInterval(exiperingTokenTime),
                             expireRefreshDate: Date().addingTimeInterval(expireRefreshTokenTime))
        case let .failure(reason):
            debugPrint("[DEBUG]: Validation of token has failed, reason: \(reason ?? "No reason")")
            throw ValidationTokenErrors.cannotRefreshToken
        }
    }
}

// MARK: ValidationTokenManager
extension ValidationTokenManagerImpl: ValidationTokenManager {
    var isValidRefresh: Bool {
        guard let user = accountManager.getUser(),
              let token = keyChainManager.read(service: PPToken.kTokensKeyChain,
                                               account: "\(user.id)",
                                               type: TokenInfo.self)
        else {
            return false
        }
        
        if !token.isValidRefresh {
            removeTokens()
        }
        
        return token.isValidRefresh
    }
    
    func saveTokens(_ tokens: PPToken) throws {
        do {
            guard let user = accountManager.getUser() else {
                throw ValidationTokenErrors.savingFaild
            }
            let expireDate = Date().addingTimeInterval(exiperingTokenTime)
            let expireRefreshTime = Date().addingTimeInterval(expireRefreshTokenTime)
            let tokenInfo = TokenInfo(tokens: tokens, expireDate: expireDate, expireRefreshDate: expireRefreshTime)
            
            try keyChainManager.save(tokenInfo,
                                     service: PPToken.kTokensKeyChain,
                                     account: "\(user.id)")
        } catch {
            throw error
        }
    }
    
    func removeTokens() {
        guard let user = accountManager.getUser() else {
            return
        }
        keyChainManager.delete(service: PPToken.kTokensKeyChain, account: "\(user.id)")
    }
    
    func getAccessToken() async throws -> String {
        guard let user = accountManager.getUser(),
              let token = keyChainManager.read(service: PPToken.kTokensKeyChain,
                                               account: "\(user.id)",
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
    
    func getValidTokens() async throws -> (access: String, refresh: String) {
        let accessToken = try await getAccessToken()
        let refreshToken = try getCurrentTokens().refresh
        
        return (accessToken, refreshToken)
    }
    
    func getCurrentTokens() throws -> (access: String, refresh: String) {
        guard let user = accountManager.getUser(),
              let token = keyChainManager.read(service: PPToken.kTokensKeyChain,
                                               account: "\(user.id)",
                                               type: TokenInfo.self)
        else {
            throw ValidationTokenErrors.noSavedTokens
        }
        
        return (token.accessToken, token.refreshToken)
    }
}
