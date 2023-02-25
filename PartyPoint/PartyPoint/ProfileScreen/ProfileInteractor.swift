//
//  ProfileInteractor.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import Foundation

final class ProfileInteractor {
	weak var output: ProfileInteractorOutput?
    private let profileContentProvider: ProfileContentProvider
    private let authManager: AuthManager
    private let accountManager: PPAccountManager
    private let tokenManager: ValidationTokenManager
    
    init(profileContentProvider: ProfileContentProvider,
         authManager: AuthManager,
         accountManager: PPAccountManager,
         tokenManager: ValidationTokenManager) {
        self.profileContentProvider = profileContentProvider
        self.authManager = authManager
        self.accountManager = accountManager
        self.tokenManager = tokenManager
    }
}

extension ProfileInteractor: ProfileInteractorInput {
    func getUser() {
        output?.showUserInfo(info: profileContentProvider.getUser())
    }
    
    func exit() {
        Task {
            let result = await authManager.logout()
            switch result {
            case .authorized:
                await runOnMainThread {
                    tokenManager.removeTokens()
                    accountManager.removeUser()
                    output?.performSuccessExit()
                }
                
                print(accountManager.getUser())
                print(try? await tokenManager.getAccessToken())
            case let .nonAuthoraized(reason):
                await runOnMainThread {
                    guard let reason = reason else {
                        output?.showErrorWhenExit(reason: Localizable.somthing_goes_wrong())
                        return
                    }
                    output?.showErrorWhenExit(reason: reason)
                }
            }
        }
    }
}
