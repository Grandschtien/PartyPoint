//
//  EnterContainer.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import UIKit

final class EnterContainer {
    let input: EnterModuleInput
	let viewController: UIViewController
	private(set) weak var router: EnterRouterInput!

	static func assemble(with context: EnterContext) -> EnterContainer {
        let router = EnterRouter(mainFlowCoordinator: context.mainFlowCoordinator)
        let networkRouter = Router<AuthEndPoint>()
        let authManager = AuthManagerImpl(router: networkRouter)
        let decoder = PPDecoderImpl<PPUser>()
        let interactor = EnterInteractor(authManager: authManager, decoder: decoder)
        let presenter = EnterPresenter(router: router,
                                       interactor: interactor)
		let viewController = EnterViewController(output: presenter)
        
        router.setViewController(viewController)
		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return EnterContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: EnterModuleInput, router: EnterRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct EnterContext {
	weak var moduleOutput: EnterModuleOutput?
    let mainFlowCoordinator: Coordinator
}
