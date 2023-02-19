//
//  FogotPasswordProtocols.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//  
//

import Foundation

protocol FogotPasswordModuleInput {
	var moduleOutput: FogotPasswordModuleOutput? { get }
}

protocol FogotPasswordModuleOutput: AnyObject {
}

protocol FogotPasswordViewInput: AnyObject {
    func showEmailEmpty(errorText: String)
    func performError(reason: String)
    func setIsLoading(isLoading: Bool)
}

protocol FogotPasswordViewOutput: AnyObject {
    func backButtonPressed()
    func sendCode(toEmail email: String?)
}

protocol FogotPasswordInteractorInput: AnyObject {
    func sendCode(withEmail email: String)
}

protocol FogotPasswordInteractorOutput: AnyObject {
    func performSuccess(email: String)
    func performFailure(reason: String)
}

protocol FogotPasswordRouterInput: AnyObject {
    func routeBack()
    func openSendCodeScreen(with email: String)
}
