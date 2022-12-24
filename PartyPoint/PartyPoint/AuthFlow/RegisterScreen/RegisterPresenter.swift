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

// MARK: Private extension
private extension RegisterPresenter {
    func getIndexesOfEmptyFields(registerInfo: [String?]) -> [Int] {
        var result = [Int]()
        for (index, info) in registerInfo.enumerated() {
            guard let info = info else {
                result.append(index)
                continue
            }
            if info.isEmpty {
                result.append(index)
            }
        }
        return result
    }
}

extension RegisterPresenter: RegisterModuleInput {
}

extension RegisterPresenter: RegisterViewOutput {
    func backButtonPressed() {
        router.routeBack()
    }
    
    func registeButtonPressed(registerInfo: [String?]) {
        let emptyFieldsIndexes = getIndexesOfEmptyFields(registerInfo: registerInfo)
        if emptyFieldsIndexes.isEmpty {
            interactor.registerUser(with: registerInfo)
        } else {
            view?.showEmptyFields(withIndexes: emptyFieldsIndexes)
        }
    }

}

extension RegisterPresenter: RegisterInteractorOutput {
}
