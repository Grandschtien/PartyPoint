//
//  BaseRouter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 30.08.2022.
//

import UIKit

class BaseRouter {
    private weak var viewController: UIViewController?
}

// MARK: Public methods
extension BaseRouter {
    func push(vc: UIViewController, animated: Bool) {
        viewController?.navigationController?.pushViewController(vc, animated: animated)
    }
    
    func pop(animated: Bool) {
        viewController?.navigationController?.popViewController(animated: animated)
    }
    
    func dismiss(animated: Bool) {
        viewController?.dismiss(animated: animated)
    }
    
    func popToRoot(animated: Bool) {
        viewController?.navigationController?.popToRootViewController(animated: animated)
    }
    
    func popToViewController(vc: UIViewController, animated: Bool) {
        self.viewController?.navigationController?.popToViewController(vc, animated: animated)
    }
    
    func show(vc: UIViewController, sender: Any?) {
        viewController?.show(vc, sender: sender)
    }
    
    func setViewController(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func present(vc: UIViewController, animated: Bool) {
        viewController?.present(vc, animated: animated)
    }
    
    var currentViewController: UIViewController? {
        return viewController
    }
}
