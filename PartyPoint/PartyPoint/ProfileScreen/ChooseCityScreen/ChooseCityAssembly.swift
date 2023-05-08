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

    static func assemble() -> ChooseCityAssembly {
        let presenter = ChooseCityPresenterImpl()
        let viewController = ChooseCityViewController(presenter: presenter)
        presenter.setView(viewController)

        return ChooseCityAssembly(view: viewController)
    }

    private init(view: UIViewController) {
        self.viewController = view
    }
}

