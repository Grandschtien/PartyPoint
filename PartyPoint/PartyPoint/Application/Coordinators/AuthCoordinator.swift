//
//  AuthCoordinator.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import UIKit

protocol CoordinatorProtocol {
    func start()
}

final class AuthCoordinator: CoordinatorProtocol {
    private let window: UIWindow
      private var navigationController = UINavigationController()
      init(window: UIWindow) {
          self.window = window
      }
    
      func start() {
          let initialAssembly = InitialAssembly.assembly()
          navigationController.setViewControllers([initialAssembly.viewController], animated: false)
          window.rootViewController = navigationController
          window.makeKeyAndVisible()
      }
}
