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
    
    init(router: EnterRouterInput, interactor: EnterInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EnterPresenter: EnterModuleInput {
}

extension EnterPresenter: EnterViewOutput {
}

extension EnterPresenter: EnterInteractorOutput {
}
