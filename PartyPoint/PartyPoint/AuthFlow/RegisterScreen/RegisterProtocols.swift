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
}

protocol RegisterViewOutput: AnyObject {
    func backButtonPressed()
    func registeButtonPressed(registerInfo: [String?]) 
}

protocol RegisterInteractorInput: AnyObject {
    func registerUser(with info: [String?])
}

protocol RegisterInteractorOutput: AnyObject {
}

protocol RegisterRouterInput: AnyObject {
    func routeBack()
}
