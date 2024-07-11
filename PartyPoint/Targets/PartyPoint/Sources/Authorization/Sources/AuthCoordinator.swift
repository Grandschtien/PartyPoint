//
//  AuthCoordinator.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import UIKit
import PartyPointNavigation

final class AuthCoordinator: Coordinator {
    private let window: UIWindow
    private var navigationController = UINavigationController()
    private let mainFlowCoordinator: Coordinator

    init(window: UIWindow, mainFlowCoordinator: Coordinator) {
        self.window = window
        self.mainFlowCoordinator = mainFlowCoordinator
    }

    func start() {
        let initialAssembly = InitialAssembly.assembly(mainFlowCoordinator: mainFlowCoordinator)
        navigationController.setViewControllers([initialAssembly.viewController], animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {})
    }
}
