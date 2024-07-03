//
//  InitialAssembly.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import UIKit

final class InitialAssembly {
    let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
        print("init \(self)")
    }
    
    deinit {
        print("deinited \(self)")
    }
    
    static func assembly(mainFlowCoordinator: Coordinator) -> InitialAssembly {
        let router = InitialRouterImpl(mainFlowCoordinator: mainFlowCoordinator)
        let initialVC = InitialViewController(router: router)
        router.setViewController(initialVC)
        return InitialAssembly(viewController: initialVC)
    }
}
