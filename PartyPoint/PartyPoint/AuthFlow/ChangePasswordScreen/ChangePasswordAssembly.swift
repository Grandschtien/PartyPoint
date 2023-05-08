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

    // creditail - может быть токеном или почтой, зависит от контекста
    static func assemble(creditail: String, state: ChangePasswordPresenterImpl.ChangePasswordState) -> ChangePasswordAssembly {
        let networkRouter = Router<AuthEndPoint>()
        let authManager = AuthManagerImpl(router: networkRouter)
        let accountManager = AccountManangerFabric.assembly()
        let presenter = ChangePasswordPresenterImpl(email: creditail,
                                                    authManager: authManager,
                                                    accounManager: accountManager,
                                                    state: state)
        let viewController = ChangePasswordViewController(presenter: presenter)
        presenter.setView(viewController)

        return ChangePasswordAssembly(view: viewController)
    }

    private init(view: UIViewController) {
        self.viewController = view
    }
}

