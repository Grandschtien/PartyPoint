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
    private let validationTokenMananger: ValidationTokenManager
    private let accountManager: PPAccountManager
    
    init(authManager: AuthManager,
         validationTokenMananger: ValidationTokenManager,
         accountManager: PPAccountManager) {
        self.authManager = authManager
        self.validationTokenMananger = validationTokenMananger
        self.accountManager = accountManager
    }
}

// MARK: - Private methods -
private extension EnterInteractor {
    func saveTokens(_ tokens: PPToken) async {
        do {
            try validationTokenMananger.saveTokens(tokens)
        } catch {
            await runOnMainThread {
                output?.notAuthorized(withReason: Localizable.somthing_goes_wrong())
            }
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
        let userInfo = accountManager.parseUserInformation(data: data)
        guard let userInfo = userInfo  else {
            await runOnMainThread {
                output?.notAuthorized(withReason: Localizable.somthing_goes_wrong())
            }
            return
        }
        
        accountManager.setUser(user: userInfo.user)
        await saveTokens(userInfo.tokens)
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

