//
//  AppCoordinator.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import UIKit

protocol AppCoordinator: AnyObject {
    func atartAuth()
    func startMain()
}

final class AppCoordinatorImpl: AppCoordinator {
    private let window: UIWindow
    private let authFlow: Coordinator
    private let mainFlow: Coordinator

    init(window: UIWindow) {
        self.window = window
        self.mainFlow = MainFlowCoordinator(window: window)
        self.authFlow = AuthCoordinator(window: window, mainFlowCoordinator: mainFlow)
    }
    
    func atartAuth() {
        authFlow.start()
    }
    
    func startMain() {
        mainFlow.start()
    }
}
