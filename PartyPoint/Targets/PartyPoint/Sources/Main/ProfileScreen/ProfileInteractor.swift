//
//  ProfileInteractor.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import Foundation
import PartyPointResources

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
    
    func openChangePasswordScreen() {
        Task {  @MainActor in
            do {
                let token = try await tokenManager.getAccessToken()
                
                output?.openChangePasswordScreen(with: token)
            } catch {
                debugPrint("[DEBUG] - Password did not change. Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getCurrentCHosenCity() -> String {
        return accountManager.getUser()?.city ?? "msk"
    }
    
    func exit() {
        Task {  @MainActor in
            do {
                let tokens = try await tokenManager.getValidTokens()
                let result = await authManager.logout(accessToken: tokens.access, refreshToken: tokens.refresh)
                switch result {
                case .success:
                    tokenManager.removeTokens()
                    accountManager.removeUser()
                    output?.performSuccessExit()
                case let .failure(reason):
                    guard let reason = reason else {
                        output?.showErrorWhenExit(reason: PartyPointResourcesStrings.Localizable.somthingGoesWrong)
                        return
                    }
                    output?.showErrorWhenExit(reason: reason)
                }
            } catch ValidationTokenErrors.noSavedTokens {
                output?.showErrorWhenExit(reason: PartyPointResourcesStrings.Localizable.noToken)
            } catch {
                debugPrint("[DEBUG] - Error was accured when user tried to logout, reason: \(error.localizedDescription)")
            }
        }
    }
}
