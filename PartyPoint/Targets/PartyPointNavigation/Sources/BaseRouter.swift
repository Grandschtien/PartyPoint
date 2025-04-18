//
//  BaseRouter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 30.08.2022.
//

import UIKit

open class BaseRouter {
    private weak var viewController: UIViewController?
    public init() {}
}

// MARK: Public methods
extension BaseRouter {
    public func push(vc: UIViewController, animated: Bool) {
        viewController?.navigationController?.pushViewController(vc, animated: animated)
    }
    
    public func pop(animated: Bool) {
        viewController?.navigationController?.popViewController(animated: animated)
    }
    
    public func dismiss(animated: Bool) {
        viewController?.dismiss(animated: animated)
    }
    
    public func popToRoot(animated: Bool) {
        viewController?.navigationController?.popToRootViewController(animated: animated)
    }
    
    public func popToViewController(vc: UIViewController, animated: Bool) {
        self.viewController?.navigationController?.popToViewController(vc, animated: animated)
    }
    
    public func show(vc: UIViewController, sender: Any?) {
        viewController?.show(vc, sender: sender)
    }
    
    public func setViewController(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    public func present(vc: UIViewController, animated: Bool) {
        viewController?.present(vc, animated: animated)
    }
    
    public var currentViewController: UIViewController? {
        return viewController
    }
}
