//
//  EnterInteractor.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import Foundation

final class EnterInteractor {
    weak var output: EnterInteractorOutput?
    private let authManager: AuthManager
    private let decoder: PPDecoder
    private let keyChainManager: KeyChainMananger
    
    init(authManager: AuthManager,
         decoder: PPDecoder,
         keyChainManager: KeyChainMananger) {
        self.authManager = authManager
        self.decoder = decoder
        self.keyChainManager = keyChainManager
    }
}

// MARK: - Private methods -
private extension EnterInteractor {
    func parseUserInformation(data: Data?) -> PPUser? {
        guard let data = data else { return nil }
        let userInfo = decoder.parseJSON(from: data, type: PPUser.self)
        return userInfo
    }
    
    func saveTokens(_ token: PPToken) -> Bool {
        do {
            try keyChainManager.save(token,
                                     service: PPToken.kTokensKeyChain,
                                     account: PPToken.kTokensKeyChain)
            return true
        } catch {
            return false
        }
    }
    
    func performNonAthorizedFlow(withReason reason: String?) async {
        guard let reason = reason else {
            await runOnMainThread {
                output?.notAuthorized(withReason: Localizable.somthing_goes_wrong())
            }
            return
        }
        await runOnMainThread {
            output?.notAuthorized(withReason: reason)
        }
    }
    
    func performAuthorizedFlow(withData data: Data?) async {
        let userInfo = parseUserInformation(data: data)
        guard let userInfo = userInfo, saveTokens(userInfo.tokens) else {
            output?.notAuthorized(withReason: Localizable.somthing_goes_wrong())
            return
        }
        
        await runOnMainThread {
            output?.authorized()
        }
    }
}

extension EnterInteractor: EnterInteractorInput {
    func enterButtonPressed(email: String, password: String) {
        Task {
            let status = await authManager.login(with: email, password: password)
            switch status {
            case let .authorized(data):
                await performAuthorizedFlow(withData: data)
            case let .nonAuthoraized(reason):
                await performNonAthorizedFlow(withReason: reason)
            }
        }
    }
}

