//
//  AppCoordinator.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import UIKit

protocol AppCoordinator: AnyObject {
    func start()
}

final class AppCoordinatorImpl: AppCoordinator {
    private let window: UIWindow
    private let authFlow: Coordinator
    private let mainFlow: Coordinator
    private let storage: UserDefaultsManager
    
    private var isLogged: Bool {
        return storage.getIsLogged()
    }

    init(window: UIWindow, userDefaultsManager: UserDefaultsManager) {
        self.window = window
        self.storage = userDefaultsManager
        self.mainFlow = MainFlowCoordinator(window: window)
        self.authFlow = AuthCoordinator(window: window, mainFlowCoordinator: mainFlow)
    }
    
    func start() {
        if isLogged {
            mainFlow.start()
        } else {
            authFlow.start()
        }
    }
}
