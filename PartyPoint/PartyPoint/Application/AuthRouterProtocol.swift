//
//  AuthRouterProtocol.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//

import Foundation
import UIKit

protocol AuthRouterProtocol: AnyObject {
    var window: UIWindow { get set }
    var viewController: UIViewController { get set }
    func setViewController(viewController: UIViewController)
    init(window: UIWindow)
    init()
}

extension AuthRouterProtocol {
    init(window: UIWindow) {
        self.init()
        self.window = window
    }
    
    func setViewController(viewController: UIViewController) {
        self.viewController = viewController
    }
}
