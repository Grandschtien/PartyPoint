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
    weak var viewController: UIViewController?
    
    func navigateToEnter() {
        let context = EnterContext(moduleOutput: nil)
        let assembly = EnterContainer.assemble(with: context)
        viewController?.navigationController?.pushViewController(assembly.viewController, animated: true)
    }
}
