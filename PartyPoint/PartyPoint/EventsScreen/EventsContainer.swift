//
//  EventsContainer.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import UIKit

final class EventsContainer {
    let input: EventsModuleInput
	let viewController: UIViewController
	private(set) weak var router: EventsRouterInput!

	static func assemble(with context: EventsContext) -> EventsContainer {
        let router = EventsRouter()
        let interactor = EventsInteractor()
        let presenter = EventsPresenter(router: router, interactor: interactor)
		let viewController = EventsViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return EventsContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: EventsModuleInput, router: EventsRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct EventsContext {
	weak var moduleOutput: EventsModuleOutput?
}
