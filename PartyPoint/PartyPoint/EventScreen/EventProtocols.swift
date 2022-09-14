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

protocol EventModuleOutput: AnyObject {
}

protocol EventViewInput: AnyObject {
}

protocol EventViewOutput: AnyObject {
    func backAction()
}

protocol EventInteractorInput: AnyObject {
}

protocol EventInteractorOutput: AnyObject {
}

protocol EventRouterInput: AnyObject {
    func backToPrevController()
}
