//
//  EventsProtocols.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import Foundation

protocol EventsModuleInput {
	var moduleOutput: EventsModuleOutput? { get }
}

protocol EventsModuleOutput: AnyObject {
}

protocol EventsViewInput: AnyObject {
}

protocol EventsViewOutput: AnyObject {
}

protocol EventsInteractorInput: AnyObject {
}

protocol EventsInteractorOutput: AnyObject {
}

protocol EventsRouterInput: AnyObject {
}
