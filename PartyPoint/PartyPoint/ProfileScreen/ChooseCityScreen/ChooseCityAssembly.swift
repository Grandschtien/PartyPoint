//
//  ChooseCityAssembly.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 08.05.2023.
//  
//

import UIKit

final class ChooseCityAssembly {
    let viewController: UIViewController

    static func assemble(with city: String) -> ChooseCityAssembly {
        let accountManager = AccountManangerFabric.assembly()
        let presenter = ChooseCityPresenterImpl(chosenCity: city, accountManager: accountManager)
        let viewController = ChooseCityViewController(presenter: presenter)
        presenter.setView(viewController)

        return ChooseCityAssembly(view: viewController)
    }

    private init(view: UIViewController) {
        self.viewController = view
    }
}

