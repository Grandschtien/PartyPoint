//
//  AppCoordinator.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import UIKit

protocol AppCoordinatorProtocol {
    func atartAuth()
    func startMain()
}

final class AppCoordinator: AppCoordinatorProtocol {
    
    private let window: UIWindow
    private var authFlow: CoordinatorProtocol?
    private var mainFlow: CoordinatorProtocol?

    init(window: UIWindow) {
        self.window = window
    }
    func atartAuth() {
        authFlow = AuthCoordinator(window: window)
        authFlow?.start()
    }
    
    func startMain() {
        mainFlow = MainFlowCoordinator(window: window)
        mainFlow?.start()
    }
}
