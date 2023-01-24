//
//  EventContainer.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 16.08.2022.
//  
//

import UIKit

final class EventContainer {
    let input: EventModuleInput
	let viewController: UIViewController
	private(set) weak var router: EventRouterInput!

	static func assemble(with context: EventContext) -> EventContainer {
        let router = EventRouter()
        let networkRouter = Router<EventsEndPoint>()
        let eventsManager = EventsManagerImpl(router: networkRouter)
        let decoder = PPDecoderImpl()
        let interactor = EventInteractor(eventId: context.eventId,
                                         placeId: context.placeId,
                                         eventsManager: eventsManager,
                                         decoder: decoder)
        let presenter = EventPresenter(router: router, interactor: interactor)
		let viewController = EventViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
        router.setViewController(viewController)
		interactor.output = presenter

        return EventContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: EventModuleInput, router: EventRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct EventContext {
	weak var moduleOutput: EventModuleOutput?
    let eventId: Int
    let placeId: Int
}
