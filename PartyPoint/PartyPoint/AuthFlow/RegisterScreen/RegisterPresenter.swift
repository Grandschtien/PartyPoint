//
//  RegisterPresenter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//  
//

import Foundation

final class RegisterPresenter {
	weak var view: RegisterViewInput?
    weak var moduleOutput: RegisterModuleOutput?
    
	private let router: RegisterRouterInput
	private let interactor: RegisterInteractorInput
    
    init(router: RegisterRouterInput, interactor: RegisterInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension RegisterPresenter: RegisterModuleInput {
}

extension RegisterPresenter: RegisterViewOutput {
    func backButtonPressed() {
        router.routeBack()
    }
    
    func registeButtonPressed(registerInfo: [String?]) async {
        await interactor.registerUser(with: registerInfo)
    }

}

extension RegisterPresenter: RegisterInteractorOutput {
}
