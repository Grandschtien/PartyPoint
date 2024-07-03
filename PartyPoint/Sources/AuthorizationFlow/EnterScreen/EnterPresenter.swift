//
//  EnterPresenter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import Foundation

final class EnterPresenter {
	weak var view: EnterViewInput?
    weak var moduleOutput: EnterModuleOutput?
    
	private let router: EnterRouterInput
	private let interactor: EnterInteractorInput
    
    init(router: EnterRouterInput,
         interactor: EnterInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EnterPresenter: EnterModuleInput {
}

extension EnterPresenter: EnterViewOutput {
    func onViewDidLoad() {
        interactor.requestLocationPermission()
    }
    
    func enterButtonPressed(email: String, passwd: String) {
        let (isLoginEmpty, isPasswdEmpty) = checkTextFieldsIsEmpty(login: email, password: passwd)
        
        if isPasswdEmpty && isLoginEmpty {
            view?.showTFIsEmptyView()
        } else if isPasswdEmpty {
            view?.showPasswordTFIsEmpty()
        } else if isLoginEmpty {
            view?.showLoginTFIsEmpty()
        } else {
            interactor.enterButtonPressed(email: email, password: passwd)
        }
    }
    
    func fogotPasswordButtonPressed() {
        router.routeToFogotPasswordScreen()
    }
    
    func registerButtonPressed() {
        router.routeToRegisterscreen()
    }
    
    func noAccountButtonPressed() {
        router.startMainWithoutAccountFlow()
    }
    
    func checkTextFieldsIsEmpty(login: String,
                                password: String) -> (loginEmpty: Bool, passwdEmpty: Bool) {
        return (login.isEmpty, password.isEmpty)
    }
}

extension EnterPresenter: EnterInteractorOutput {
    func authorized() {
        router.startMainWithAccountFlow()
    }
    
    func notAuthorized(withReason reason: String) {
        view?.showUnAuthorizereaon(reason: reason)
    }
}
