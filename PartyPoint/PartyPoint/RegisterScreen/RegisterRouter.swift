//
//  RegisterRouter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//  
//

import UIKit

final class RegisterRouter {
    private(set) var viewController: UIViewController?
    private let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    
    func setViewController(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension RegisterRouter: RegisterRouterInput {
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}

