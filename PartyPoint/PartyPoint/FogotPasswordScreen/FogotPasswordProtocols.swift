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

protocol FogotPasswordModuleOutput: class {
}

protocol FogotPasswordViewInput: class {
}

protocol FogotPasswordViewOutput: class {
}

protocol FogotPasswordInteractorInput: class {
}

protocol FogotPasswordInteractorOutput: class {
}

protocol FogotPasswordRouterInput: class {
}
