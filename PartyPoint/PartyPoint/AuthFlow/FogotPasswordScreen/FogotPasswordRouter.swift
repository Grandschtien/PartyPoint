//
//  FogotPasswordRouter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//  
//

import UIKit

final class FogotPasswordRouter {
    private(set) var viewController: UIViewController?
    
    func setViewController(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension FogotPasswordRouter: FogotPasswordRouterInput {
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
