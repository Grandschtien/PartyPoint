//
//  AcceptPasswordAssebly.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 08.02.2023.
//

import UIKit

final class AcceptPasswordAssebly {
    let viewController: UIViewController

    static func assemble(email: String) -> AcceptPasswordAssebly {
        let authManager = AuthManagerFabric.assembly()
        let presenter = AcceptPasswordPresenterImpl(authManager: authManager, email: email)
        let viewController = AcceptPasswordViewController(presenter: presenter)
        presenter.setView(viewController)

        return AcceptPasswordAssebly(view: viewController)
    }

    private init(view: UIViewController) {
        self.viewController = view
    }
}
