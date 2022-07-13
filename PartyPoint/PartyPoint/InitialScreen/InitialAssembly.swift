//
//  InitialAssembly.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import UIKit

final class InitialAssembly {
    let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    static func assembly() -> InitialAssembly {
        let router = InitialRouter()
        let initialVC = InitialViewController(router: router)
        router.viewController = initialVC
        return InitialAssembly(viewController: initialVC)
    }
}
