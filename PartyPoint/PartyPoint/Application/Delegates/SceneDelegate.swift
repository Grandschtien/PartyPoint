//
//  SceneDelegate.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinatorProtocol?
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.overrideUserInterfaceStyle = .dark
        guard let window = window else {
            return
        }
        coordinator = AppCoordinator(window: window)
        
        //TODO: Condition
        
//        coordinator?.startMain()
        coordinator?.atartAuth()
    }
}

