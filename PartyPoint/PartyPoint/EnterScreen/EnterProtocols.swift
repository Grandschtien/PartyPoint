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
}

protocol EnterViewOutput: AnyObject {
    func enterButtonPressed()
    func fogotPasswordButtonPressed()
    func registerButtonPressed()
    func noAccountButtonPressed()
}

protocol EnterInteractorInput: AnyObject {
}

protocol EnterInteractorOutput: AnyObject {
}

protocol EnterRouterInput: AnyObject {
    func routeToRegisterscreen()
    func routeToFogotPasswordScreen()
    func startMainWithAccountFlow()
    func startMainWithoutAccountFlow()
}
