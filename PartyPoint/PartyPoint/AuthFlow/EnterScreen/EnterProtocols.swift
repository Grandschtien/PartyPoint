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
    func showTFIsEmptyView()
    func showLoginTFIsEmpty()
    func showPasswordTFIsEmpty()
    func showUnAuthorizereaon(reason: String)
}

protocol EnterViewOutput: AnyObject {
    func enterButtonPressed(email: String, passwd: String)
    func fogotPasswordButtonPressed()
    func registerButtonPressed()
    func noAccountButtonPressed()
}

protocol EnterInteractorInput: AnyObject {
    func enterButtonPressed(email: String, password: String)
}

protocol EnterInteractorOutput: AnyObject {
    func authorized()
    func notAuthorized(withReason reason: String)
}

protocol EnterRouterInput: AnyObject {
    func routeToRegisterscreen()
    func routeToFogotPasswordScreen()
    func startMainWithAccountFlow()
    func startMainWithoutAccountFlow()
}
