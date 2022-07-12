//
//  InitialRouter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import Foundation
import UIKit

protocol InitilaRouterProtocol: AnyObject {
    func navigateToEnter()
}

final class InitialRouter: InitilaRouterProtocol {
    let viewController: UIViewController
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToEnter() {
        
    }
    
}
