//
//  ChangePasswordPresenterImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.02.2023.
//

import Foundation
import PartyPointNetworking
import PartyPointResources

final class ChangePasswordPresenterImpl {
    
    enum ChangePasswordState {
        case profile
        case resetPassword
    }
    
    private weak var view: ChangePasswordView?
    private let authManager: AuthManager
    private let accountManager: PPAccountManager
    private let email: String
    private var state: ChangePasswordState
    
    init(email: String,
         authManager: AuthManager,
         accounManager: PPAccountManager,
         state: ChangePasswordState) {
        self.email = email
        self.authManager = authManager
        self.accountManager = accounManager
        self.state = state
    }
}

// MARK: Private methods
private extension ChangePasswordPresenterImpl {
    func isPasswordMatch(password: String, checkPassword: String) -> Bool {
        return password != checkPassword
    }
    
    func changePassword(newPassword: String) {
        Task { @MainActor in
            let status: NetworkManager.DefaultResultOfRequest
            switch state {
            case .profile:
                status = await accountManager.changePassword(token: email, password: newPassword)
            case .resetPassword:
                status = await authManager.sendNewPassword(email: email, password: newPassword)
            }
            
            switch status {
            case .success:
                view?.showLoading(isLoading: false)
                view?.performSuccess()
            case let .failure(reason):
                if let reason = reason {
                    view?.showLoading(isLoading: false)
                    view?.showError(reason: reason)
                } else {
                    view?.showLoading(isLoading: false)
                    view?.showError(reason: PartyPointResourcesStrings.Localizable.somthingGoesWrong)
                }
            }
        }
    }
}

// MARK: Public methods
extension ChangePasswordPresenterImpl {
    func setView(_ view: ChangePasswordView) {
        self.view = view
    }
}

// MARK: ChangePasswordPresenter
extension ChangePasswordPresenterImpl: ChangePasswordPresenter {
    func sendNewPassword(password: String?, checkPassword: String?) {
        guard let password = password,
              let checkPassword = checkPassword,
              !password.isEmpty,
              !checkPassword.isEmpty else {
            view?.showEmptyFileds()
            return
        }
        
        if isPasswordMatch(password: password, checkPassword: checkPassword) {
            view?.showError(reason: PartyPointResourcesStrings.Localizable.passwordDoesntMatch)
            return
        }
        
        view?.showLoading(isLoading: true)
        changePassword(newPassword: password)
    }
}

