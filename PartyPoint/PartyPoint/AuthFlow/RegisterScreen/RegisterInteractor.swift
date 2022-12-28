//
//  RegisterInteractor.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//  
//

import Foundation

final class RegisterInteractor {
    private let authManager: AuthManager
    private let keyChainManager: KeyChainMananger
    private let decoder: PPDecoder
    
	weak var output: RegisterInteractorOutput?
    
    init(authManager: AuthManager,
         keyChainManager: KeyChainMananger,
         decoder: PPDecoder) {
        self.authManager = authManager
        self.keyChainManager = keyChainManager
        self.decoder = decoder
    }
}

//MARK: Private methods
private extension RegisterInteractor {
    func parseUserInformation(data: Data?) -> PPUser? {
        guard let data = data else { return nil }
        let userInfo = decoder.parseJSON(from: data, type: PPUser.self)
        return userInfo
    }
    
    func performRegisterFlow(withData data: Data?) async {
        let userInfo = parseUserInformation(data: data)
        guard let userInfo = userInfo, saveTokens(userInfo.tokens) else {
            output?.registerFailed(withReason: Localizable.somthing_goes_wrong())
            return
        }
        
        await runOnMainThread {
            output?.userRegistered()
        }
    }
    
    func performRegisterFaildFlow(reason: String?) async {
        guard let reason = reason else {
            await runOnMainThread {
                output?.registerFailed(withReason: Localizable.somthing_goes_wrong())
            }
            return
        }
        
        await runOnMainThread {
            output?.registerFailed(withReason: reason)
        }
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
}

extension RegisterInteractor: RegisterInteractorInput {
    func registerUser(with info: [String?]) {
        Task {
            let validateInfo = info.compactMap{$0}
            let authStatus = await authManager.register(with: validateInfo[0],
                                                      surname: validateInfo[1],
                                                      mail: validateInfo[2],
                                                      password: validateInfo[3])
            
            switch authStatus {
            case let .authorized(data):
                await performRegisterFlow(withData: data)
            case let .nonAuthoraized(reason):
                await performRegisterFaildFlow(reason: reason)
            }
        }
    }
}
