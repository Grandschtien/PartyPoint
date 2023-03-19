//
//  SearchScreenAssembly.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 24.02.2023.
//  
//

import UIKit

final class SearchScreenAssembly {
    let viewController: UIViewController

    static func assemble() -> SearchScreenAssembly {
        let searchManager = SearchManangerFactory.assembly()
        let decoder = PPDecoderImpl()
        let contentLoader = SearchContentLoaderImpl(searchManager: searchManager, decoder: decoder)
        let presenter = SearchScreenPresenterImpl(contentLoader: contentLoader)
        let viewController = SearchScreenViewController(presenter: presenter)
        presenter.setView(viewController)

        return SearchScreenAssembly(view: viewController)
    }

    private init(view: UIViewController) {
        self.viewController = view
    }
}

