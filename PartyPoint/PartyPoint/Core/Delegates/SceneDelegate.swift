//
//  SceneDelegate.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import UIKit

typealias Localizable = R.string.localizable
typealias Images = R.image
typealias Colors = R.color
typealias Fonts = R.font
typealias EmptyClosure = () -> Void

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
        
        let storage = UserDefaults.standard
        coordinator = makeAppCoordinator(window: window)
        coordinator?.start()
    }
    
    func makeAppCoordinator(window: UIWindow) -> AppCoordinatorImpl {
        let storage = UserDefaults.standard
        let userDefaultsManager = UserDefaultsManagerImpl(storage: storage)
        return AppCoordinatorImpl(window: window, userDefaultsManager: userDefaultsManager)
    }
}

