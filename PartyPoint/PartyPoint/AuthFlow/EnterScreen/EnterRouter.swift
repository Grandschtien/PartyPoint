//
//  EnterRouter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import UIKit

final class EnterRouter {
    let window: UIWindow
    private(set) var viewController: UIViewController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func setViewController(viewContrller: UIViewController) {
        self.viewController = viewContrller
    }
}

extension EnterRouter: EnterRouterInput {
    func routeToRegisterscreen() {
        let context = RegisterContext(moduleOutput: nil, window: window)
        let container = RegisterContainer.assemble(with: context)
        viewController?.navigationController?.pushViewController(
            container.viewController,
            animated: true
        )
    }
    
    func routeToFogotPasswordScreen() {
        let context = FogotPasswordContext(moduleOutput: nil)
        let container = FogotPasswordContainer.assemble(with: context)
        viewController?.navigationController?.pushViewController(
            container.viewController,
            animated: true
        )
    }
    
    func startMainWithAccountFlow() {
        let appCord: AppCoordinatorProtocol = AppCoordinator(window: window)
        appCord.startMain()
    }
    
    func startMainWithoutAccountFlow() {
        let appCord: AppCoordinatorProtocol = AppCoordinator(window: window)
        appCord.startMain()
    }
}
