//
//  EnterRouter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import UIKit

final class EnterRouter: BaseRouter {
    private let mainFlowCoordinator: Coordinator
    
    init(mainFlowCoordinator: Coordinator) {
        self.mainFlowCoordinator = mainFlowCoordinator
        super.init()
    }
}

extension EnterRouter: EnterRouterInput {
    func routeToRegisterscreen() {
        let context = RegisterContext(moduleOutput: nil, mainFlowCoordinator: mainFlowCoordinator)
        let container = RegisterContainer.assemble(with: context)
        push(vc: container.viewController, animated: true)
    }
    
    func routeToFogotPasswordScreen() {
        let context = FogotPasswordContext(moduleOutput: nil)
        let container = FogotPasswordContainer.assemble(with: context)
        push(vc: container.viewController, animated: true)
    }
    
    func startMainWithAccountFlow() {
        mainFlowCoordinator.start()
    }
    
    func startMainWithoutAccountFlow() {
        mainFlowCoordinator.start()
    }
}
