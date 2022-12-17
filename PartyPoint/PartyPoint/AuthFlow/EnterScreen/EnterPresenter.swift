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
    func enterButtonPressed(email: String, passwd: String) async {
        if checkTextFieldsIsEmpty(login: email, password: passwd) {
            view?.showTFIsEmptyView()
            return
        } else {
            await interactor.enterButtonPressed(email: email, password: passwd)
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
    
    func checkTextFieldsIsEmpty(login: String, password: String) -> Bool {
        return login.isEmpty || password.isEmpty
    }
}

extension EnterPresenter: EnterInteractorOutput {
    func authorized() {
        DispatchQueue.main.async {
            self.router.startMainWithAccountFlow()
        }
    }
    
    func notAuthorized(error: String) {
        //TODO: Handle error
    }
}
