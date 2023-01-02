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
    private let validationTokenMananger: ValidationTokenManager
    private let accountMananger: PPAccountManager
    
	weak var output: RegisterInteractorOutput?
    
    init(authManager: AuthManager,
         validationTokenMananger: ValidationTokenManager,
         accountManager: PPAccountManager) {
        self.authManager = authManager
        self.validationTokenMananger = validationTokenMananger
        self.accountMananger = accountManager
    }
}

//MARK: Private methods
private extension RegisterInteractor {
    func saveTokens(tokens: PPToken) async {
        do {
            try validationTokenMananger.saveTokens(tokens)
        } catch {
            await runOnMainThread {
                output?.registerFailed(withReason: Localizable.somthing_goes_wrong())
            }
        }
    }
    
    func performRegisterFlow(withData data: Data?) async {
        let userInfo = accountMananger.parseUserInformation(data: data)
        guard let userInfo = userInfo else {
            output?.registerFailed(withReason: Localizable.somthing_goes_wrong())
            return
        }
        
        accountMananger.setUser(user: userInfo.user)
        await saveTokens(tokens: userInfo.tokens)
        
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
