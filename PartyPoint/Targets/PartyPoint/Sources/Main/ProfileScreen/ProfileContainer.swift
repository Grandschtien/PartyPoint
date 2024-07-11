//
//  ProfileContainer.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import UIKit
import PartyPointNavigation

final class ProfileContainer {
    let input: ProfileModuleInput
	let viewController: UIViewController
	private(set) weak var router: ProfileRouterInput!

	static func assemble(with context: ProfileContext) -> ProfileContainer {
        let router = ProfileRouter(appCoornator: context.appCoordinator)
        let contentProvider = ProfileContentProviderImpl(user: context.profileInfo)
        let authManager =  AuthManagerFactory.assembly()
        let accountManager = AccountManangerFactory.assembly()
        let tokenManager = TokenManagerFactory.assembly()
        let interactor = ProfileInteractor(profileContentProvider: contentProvider,
                                           authManager: authManager,
                                           accountManager: accountManager,
                                           tokenManager: tokenManager)
        let presenter = ProfilePresenter(router: router, interactor: interactor)
		let viewController = ProfileViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
        router.setViewController(viewController)
		interactor.output = presenter

        return ProfileContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: ProfileModuleInput, router: ProfileRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct ProfileContext {
	weak var moduleOutput: ProfileModuleOutput?
    let profileInfo: ProfileInfo
    let appCoordinator: AppCoordinator
}
