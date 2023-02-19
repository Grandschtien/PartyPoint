//
//  ChangePasswordAssembly.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.02.2023.
//  
//

import UIKit

final class ChangePasswordAssembly {
    let viewController: UIViewController

    static func assemble(email: String) -> ChangePasswordAssembly {
        let networkRouter = Router<AuthEndPoint>()
        let authManager = AuthManagerImpl(router: networkRouter)
        let presenter = ChangePasswordPresenterImpl(email: email, authManager: authManager)
        let viewController = ChangePasswordViewController(presenter: presenter)
        presenter.setView(viewController)

        return ChangePasswordAssembly(view: viewController)
    }

    private init(view: UIViewController) {
        self.viewController = view
    }
}

