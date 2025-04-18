//
//  EventsContainer.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import UIKit
import CoreLocation
import PartyPointCore
import PartyPointNavigation
import PartyPointNetworking

final class EventsContainer {
    let input: EventsModuleInput
	let viewController: UIViewController
	private(set) weak var router: EventsRouterInput!

	static func assemble(with context: EventsContext) -> EventsContainer {
        let router = EventsRouter(appCoordinator: context.appCoordinator)
        let systemLocationMananger = CLLocationManager()
        let locationMananger = LocationManagerImpl(locationManager: systemLocationMananger)
        let networkRouter = Router<EventsEndPoint>()
        let validationTokenManager = TokenManagerFactory.assembly()
        let accountManager = AccountManangerFactory.assembly()
        let networkMananger = EventsManagerImpl(router: networkRouter, validationTokenManager: validationTokenManager, accountManager: accountManager)
        let decoder = PPDecoderImpl()
        let likeManager = LikeManagerImpl.shared
        let contentProvider = EventsContentProviderImpl()
        let interactor = EventsInteractor(eventsManager: networkMananger,
                                          locationManager: locationMananger,
                                          decoder: decoder,
                                          contentProvider: contentProvider,
                                          accountManager: accountManager,
                                          likeManager: likeManager)
        let presenter = EventsPresenter(router: router, interactor: interactor)
		let viewController = EventsViewController(output: presenter)
        router.setViewController(viewController)
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
    let appCoordinator: AppCoordinator
}
