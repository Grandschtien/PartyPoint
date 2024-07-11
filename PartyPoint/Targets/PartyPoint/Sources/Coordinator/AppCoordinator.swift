//
//  AppCoordinator.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import UIKit
import PartyPointNavigation
import PartyPointCore

@objc protocol AppCoordinator: AnyObject {
    func start()
    func exit()
}

final class AppCoordinatorImpl: AppCoordinator, Coordinator {
    private let window: UIWindow
    private let authFlow: Coordinator
    private let mainFlow: Coordinator
    private let storage: UserDefaultsManager
    private let validateTokenManager: ValidationTokenManager
    
    private var isLogged: Bool {
        return storage.getIsLogged()
    }

    init(window: UIWindow, userDefaultsManager: UserDefaultsManager, validateTokenManager: ValidationTokenManager) {
        self.window = window
        self.storage = userDefaultsManager
        self.mainFlow = MainFlowCoordinator(window: window)
        self.authFlow = AuthCoordinator(window: window, mainFlowCoordinator: mainFlow)
        self.validateTokenManager = validateTokenManager
    }
    
    func start() {
        mainFlow.setAppCoordinator?(self)
        if isLogged && validateTokenManager.isValidRefresh {
            mainFlow.start()
        } else {
            authFlow.start()
        }
    }
    
    func exit() {
        authFlow.start()
        storage.removeIsLogged()
    }
}
