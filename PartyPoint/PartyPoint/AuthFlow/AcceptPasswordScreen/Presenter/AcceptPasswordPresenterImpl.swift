//
//  AcceptPasswordPresenterImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 08.02.2023.
//

import Foundation

final class AcceptPasswordPresenterImpl {
    private weak var view: AcceptPassswordView?
    private let authManager: AuthManager
    private let email: String
    
    init(authManager: AuthManager, email: String) {
        self.authManager = authManager
        self.email = email
    }
    
    func setView(_ view: AcceptPassswordView) {
        self.view = view
    }
}

private extension AcceptPasswordPresenterImpl {
    func checkCode(code: String?) -> Int? {
        guard let code = code, !code.isEmpty else {
            view?.showError(reason: Localizable.fill_in_this_field())
            view?.showLoader(isLoading: false)
            return nil
        }
        
        guard let numericCode = Int(code) else {
            view?.showError(reason: Localizable.uncorrect_code())
            return nil
        }
        return numericCode
    }
}

extension AcceptPasswordPresenterImpl: AcceptPasswordPresenter {
    func sendCode(code: String?) {
        view?.showLoader(isLoading: true)
        if let code = checkCode(code: code) {
            Task {
                let result = await authManager.checkConfirmCode(email: email, code: code)
                
                await runOnMainThread {
                    view?.showLoader(isLoading: false)
                    switch result {
                    case .success:
                        view?.performSuccess(email: email)
                    case let .failure(reason):
                        if let reason = reason {
                            view?.showError(reason: reason)
                        } else {
                            view?.showError(reason: Localizable.somthing_goes_wrong())
                        }
                    }
                }
            }
        }
    }
}
