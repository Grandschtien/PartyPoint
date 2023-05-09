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
    
    func openChangePasswordScreen() {
        Task {
            do {
                let token = try await tokenManager.getAccessToken()
                
                await runOnMainThread {
                    output?.openChangePasswordScreen(with: token)
                }
            } catch {
                debugPrint("[DEBUG] - Password did not change. Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getCurrentCHosenCity() -> String {
        return profileContentProvider.getUser().city
    }
    
    func exit() {
        Task {
            do {
                let tokens = try await tokenManager.getValidTokens()
                let result = await authManager.logout(accessToken: tokens.access, refreshToken: tokens.refresh)
                switch result {
                case .success:
                    await runOnMainThread {
                        tokenManager.removeTokens()
                        accountManager.removeUser()
                        output?.performSuccessExit()
                    }
                case let .failure(reason):
                    await runOnMainThread {
                        guard let reason = reason else {
                            output?.showErrorWhenExit(reason: Localizable.somthing_goes_wrong())
                            return
                        }
                        output?.showErrorWhenExit(reason: reason)
                    }
                }
            } catch ValidationTokenErrors.noSavedTokens {
                output?.showErrorWhenExit(reason: Localizable.no_token())
            } catch {
                debugPrint("[DEBUG] - Error was accured when user tried to logout, reason: \(error.localizedDescription)")
            }
        }
    }
}
