//
//  RegisterContainer.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//  
//

import UIKit
import PartyPointCore
import PartyPointNavigation

final class RegisterContainer {
    let input: RegisterModuleInput
	let viewController: UIViewController
	private(set) weak var router: RegisterRouterInput!

	static func assemble(with context: RegisterContext) -> RegisterContainer {
        
        let router = RegisterRouter(mainFlowCoordinator: context.mainFlowCoordinator)
        let authManager = AuthManagerFactory.assembly()
        let keyChainManager = KeyChainManangerImpl()
        let decoder = PPDecoderImpl()
        let accountMananger = AccountManangerFactory.assembly()
        let userDefaultsManager = UserDefaultsManagerImpl(storage: UserDefaults.standard)
        let validationTokenManager = ValidationTokenManagerImpl(keyChainManager: keyChainManager,
                                                                authManager: authManager,
                                                                accountManager: accountMananger,
                                                                decoder: decoder)
        let interactor = RegisterInteractor(authManager: authManager,
                                            validationTokenMananger: validationTokenManager,
                                            accountManager: accountMananger,
                                            userDefaultsManager: userDefaultsManager)
        let presenter = RegisterPresenter(router: router, interactor: interactor)
		let viewController = RegisterViewController(output: presenter)
        router.setViewController(viewController)
		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return RegisterContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: RegisterModuleInput, router: RegisterRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct RegisterContext {
	weak var moduleOutput: RegisterModuleOutput?
    let mainFlowCoordinator: Coordinator
}
