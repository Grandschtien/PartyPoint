//
//  SceneDelegate.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import UIKit
import PartyPointCore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.overrideUserInterfaceStyle = .dark
        
        guard let window = window else {
            return
        }
        
        coordinator = makeAppCoordinator(window: window)
        coordinator?.start()
        
        UniversalLinksManagerImpl.shared.hadnleUrlIfNeeded(with: connectionOptions.userActivities.first)
    }
    
    func makeAppCoordinator(window: UIWindow) -> AppCoordinatorImpl {
        let storage = UserDefaults.standard
        let userDefaultsManager = UserDefaultsManagerImpl(storage: storage)
        let validateTokenManager = TokenManagerFactory.assembly()
        return AppCoordinatorImpl(window: window, userDefaultsManager: userDefaultsManager, validateTokenManager: validateTokenManager)
    }
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
            UniversalLinksManagerImpl.shared.hadnleUrlIfNeeded(with: userActivity)
        }
    }
}

