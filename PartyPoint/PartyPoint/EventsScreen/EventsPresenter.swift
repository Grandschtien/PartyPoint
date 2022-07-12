//
//  EventsPresenter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import Foundation

final class EventsPresenter {
	weak var view: EventsViewInput?
    weak var moduleOutput: EventsModuleOutput?
    
	private let router: EventsRouterInput
	private let interactor: EventsInteractorInput
    
    init(router: EventsRouterInput, interactor: EventsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EventsPresenter: EventsModuleInput {
}

extension EventsPresenter: EventsViewOutput {
}

extension EventsPresenter: EventsInteractorOutput {
}
