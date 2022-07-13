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
}

protocol FogotPasswordViewOutput: AnyObject {
    func backButtonPressed()
}

protocol FogotPasswordInteractorInput: AnyObject {
}

protocol FogotPasswordInteractorOutput: AnyObject {
}

protocol FogotPasswordRouterInput: AnyObject {
    func routeBack()
}
