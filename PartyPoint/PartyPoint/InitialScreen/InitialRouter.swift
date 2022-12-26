//
//  InitialRouter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import UIKit

protocol InitialRouter {
    func navigateToEnter()
}

final class InitialRouterImpl: BaseRouter, InitialRouter {
    private let mainFlowCoordinator: Coordinator
    
    init(mainFlowCoordinator: Coordinator) {
        self.mainFlowCoordinator = mainFlowCoordinator
    }
    
    func navigateToEnter() {
        let context = EnterContext(moduleOutput: nil, mainFlowCoordinator: mainFlowCoordinator)
        let assembly = EnterContainer.assemble(with: context)
        push(vc: assembly.viewController, animated: true)
    }
}
