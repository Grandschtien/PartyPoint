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
}

protocol RegisterViewOutput: AnyObject {
    func backButtonPressed()
}

protocol RegisterInteractorInput: AnyObject {
}

protocol RegisterInteractorOutput: AnyObject {
}

protocol RegisterRouterInput: AnyObject {
    func routeBack()
}
