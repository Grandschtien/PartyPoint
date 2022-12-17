//
//  BaseRouter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 30.08.2022.
//

import UIKit

protocol BaseRouter {
    var viewController: UIViewController? { get set }
    func push(vc: UIViewController, animated: Bool)
    func pop(animated: Bool)
    func popToRoot(animated: Bool)
    func popToViewController(vc: UIViewController, animated: Bool)
    func show(vc: UIViewController, sender: Any?)
}

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
}
