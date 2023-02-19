//
//  FogotPasswordPresenter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//  
//

import Foundation

final class FogotPasswordPresenter {
	weak var view: FogotPasswordViewInput?
    weak var moduleOutput: FogotPasswordModuleOutput?
    
	private let router: FogotPasswordRouterInput
	private let interactor: FogotPasswordInteractorInput
    
    init(router: FogotPasswordRouterInput, interactor: FogotPasswordInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

private extension FogotPasswordPresenter {
    func checkEmail(_ email: String?) -> String? {
        guard let email = email, !email.isEmpty else {
            view?.showEmailEmpty(errorText: Localizable.empty_email())
            return nil
        }
        return email
    }
}

extension FogotPasswordPresenter: FogotPasswordModuleInput {
}

extension FogotPasswordPresenter: FogotPasswordViewOutput {
    func backButtonPressed() {
        router.routeBack()
    }
    
    func sendCode(toEmail email: String?) {
        if let email = checkEmail(email) {
            view?.setIsLoading(isLoading: true)
            interactor.sendCode(withEmail: email)
        }
    }
}

extension FogotPasswordPresenter: FogotPasswordInteractorOutput {
    func performSuccess(email: String) {
        view?.setIsLoading(isLoading: false)
        router.openSendCodeScreen(with: email)
    }
    
    func performFailure(reason: String) {
        view?.setIsLoading(isLoading: false)
        view?.performError(reason: reason)
    }
}
