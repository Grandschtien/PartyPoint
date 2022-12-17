//
//  EnterProtocols.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import Foundation

protocol EnterModuleInput {
	var moduleOutput: EnterModuleOutput? { get }
}

protocol EnterModuleOutput: AnyObject {
}

protocol EnterViewInput: AnyObject {
    func showError(error: String)
    func showTFIsEmptyView()
}

protocol EnterViewOutput: AnyObject {
    func enterButtonPressed(email: String, passwd: String) async
    func fogotPasswordButtonPressed()
    func registerButtonPressed()
    func noAccountButtonPressed()
}

protocol EnterInteractorInput: AnyObject {
    func enterButtonPressed(email: String, password: String) async
}

protocol EnterInteractorOutput: AnyObject {
    func authorized()
    func notAuthorized(error: String)
}

protocol EnterRouterInput: AnyObject {
    func routeToRegisterscreen()
    func routeToFogotPasswordScreen()
    func startMainWithAccountFlow()
    func startMainWithoutAccountFlow()
}
