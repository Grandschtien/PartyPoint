//
//  FogotPasswordContainer.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//  
//

import UIKit

final class FogotPasswordContainer {
    let input: FogotPasswordModuleInput
	let viewController: UIViewController
	private(set) weak var router: FogotPasswordRouterInput!

	static func assemble(with context: FogotPasswordContext) -> FogotPasswordContainer {
        let router = FogotPasswordRouter()
        let authManager = AuthManagerFactory.assembly()
        let interactor = FogotPasswordInteractor(authManager: authManager)
        let presenter = FogotPasswordPresenter(router: router, interactor: interactor)
		let viewController = FogotPasswordViewController(output: presenter)

        router.setViewController(viewController)
		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return FogotPasswordContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: FogotPasswordModuleInput, router: FogotPasswordRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct FogotPasswordContext {
	weak var moduleOutput: FogotPasswordModuleOutput?
}
