//
//  ChangePasswordPresenterImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.02.2023.
//  
//

final class ChangePasswordPresenterImpl {
    private weak var view: ChangePasswordView?
    private let authManager: AuthManager
    private let email: String
    
    init(email: String, authManager: AuthManager) {
        self.email = email
        self.authManager = authManager
    }
}

// MARK: Private methods
private extension ChangePasswordPresenterImpl {
    func isPasswordDoesntMatch(password: String, checkPassword: String) -> Bool {
        return password != checkPassword
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
        
        if isPasswordDoesntMatch(password: password, checkPassword: checkPassword) {
            view?.showError(reason: Localizable.password_doesnt_match())
            return
        }
        
        view?.showLoading(isLoading: true)
        
        Task {
            let status = await authManager.sendNewPassword(email: email, password: password)
            
            await runOnMainThread {
                switch status {
                case .authorized:
                    view?.showLoading(isLoading: false)
                    view?.performSuccess()
                case let .nonAuthoraized(reason):
                    if let reason = reason {
                        view?.showLoading(isLoading: false)
                        view?.showError(reason: reason)
                    } else {
                        view?.showLoading(isLoading: false)
                        view?.showError(reason: Localizable.somthing_goes_wrong())
                    }
                }
            }
        }
        
    }
}

