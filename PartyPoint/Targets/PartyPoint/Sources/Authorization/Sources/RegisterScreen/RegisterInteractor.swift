//
//  RegisterInteractor.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//  
//

import Foundation
import PartyPointCore
import PartyPointResources

final class RegisterInteractor {
    private let authManager: AuthManager
    private let validationTokenMananger: ValidationTokenManager
    private let accountMananger: PPAccountManager
    private let userDefaultsManager: UserDefaultsManager
    
	weak var output: RegisterInteractorOutput?
    
    init(authManager: AuthManager,
         validationTokenMananger: ValidationTokenManager,
         accountManager: PPAccountManager,
         userDefaultsManager: UserDefaultsManager) {
        self.authManager = authManager
        self.validationTokenMananger = validationTokenMananger
        self.accountMananger = accountManager
        self.userDefaultsManager = userDefaultsManager
    }
}

//MARK: Private methods
private extension RegisterInteractor {
    @MainActor
    func saveTokens(tokens: PPToken) async {
        do {
            try validationTokenMananger.saveTokens(tokens)
        } catch {
            output?.registerFailed(withReason: PartyPointResourcesStrings.Localizable.somthingGoesWrong)
        }
    }
    
    @MainActor
    func performRegisterFlow(withData data: Data?) async {
        let userInfo = accountMananger.parseUserInformation(data: data)
        guard let userInfo = userInfo else {
            output?.registerFailed(withReason: PartyPointResourcesStrings.Localizable.somthingGoesWrong)
            return
        }
        
        accountMananger.setUser(user: userInfo.user)
        userDefaultsManager.setIsLogged(true)
        await saveTokens(tokens: userInfo.tokens)
        
        output?.userRegistered()
    }
    
    @MainActor
    func performRegisterFaildFlow(reason: String?) async {
        guard let reason = reason else {
            output?.registerFailed(withReason: PartyPointResourcesStrings.Localizable.somthingGoesWrong)
            return
        }
        
        output?.registerFailed(withReason: reason)
    }
}

extension RegisterInteractor: RegisterInteractorInput {
    func registerUser(with info: PPRegisterUserInformation) {
        Task {
            let authStatus = await authManager.register(with: info)
            switch authStatus {
            case let .success(data):
                await performRegisterFlow(withData: data)
            case let .failure(reason):
                await performRegisterFaildFlow(reason: reason)
            }
        }
    }
}
