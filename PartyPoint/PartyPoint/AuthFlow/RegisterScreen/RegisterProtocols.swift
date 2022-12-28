//
//  RegisterProtocols.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//  
//

import Foundation

protocol RegisterModuleInput {
	var moduleOutput: RegisterModuleOutput? { get }
}

protocol RegisterModuleOutput: AnyObject {
}

protocol RegisterViewInput: AnyObject {
    func showEmptyFields(withIndexes indexes: [Int])
    func showToPasswordsIsDifferent()
    func showWhyRegisterFailed(reason: String)
    func showLoadingIfNeeded(isLoading: Bool)
}

protocol RegisterViewOutput: AnyObject {
    func backButtonPressed()
    func registeButtonPressed(registerInfo: [String?]) 
}

protocol RegisterInteractorInput: AnyObject {
    func registerUser(with info: [String?])
}

protocol RegisterInteractorOutput: AnyObject {
    func userRegistered()
    func registerFailed(withReason reason: String)
}

protocol RegisterRouterInput: AnyObject {
    func routeBack()
    func startMainFlow()
}
