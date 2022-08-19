//
//  EventProtocols.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 16.08.2022.
//  
//

import Foundation

protocol EventModuleInput {
	var moduleOutput: EventModuleOutput? { get }
}

protocol EventModuleOutput: class {
}

protocol EventViewInput: class {
}

protocol EventViewOutput: class {
}

protocol EventInteractorInput: class {
}

protocol EventInteractorOutput: class {
}

protocol EventRouterInput: class {
}
