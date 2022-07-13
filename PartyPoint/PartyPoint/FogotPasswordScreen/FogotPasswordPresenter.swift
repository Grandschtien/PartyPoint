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

extension FogotPasswordPresenter: FogotPasswordModuleInput {
}

extension FogotPasswordPresenter: FogotPasswordViewOutput {
}

extension FogotPasswordPresenter: FogotPasswordInteractorOutput {
}
