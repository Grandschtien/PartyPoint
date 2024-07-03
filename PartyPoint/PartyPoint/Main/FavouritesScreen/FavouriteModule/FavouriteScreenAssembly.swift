//
//  FavouriteScreenAssembly.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 15.04.2023.
//  
//

import UIKit

final class FavouriteScreenAssembly {
    let viewController: UIViewController

    static func assemble(appCoordinator: AppCoordinator) -> FavouriteScreenAssembly {
        let likeMananger = LikeManagerImpl.shared
        let accountManager = AccountManangerFactory.assembly()
        let decoder = PPDecoderImpl()
        let contentProvider = FvoritesContentProviderImpl()
        let router = FavouritesRouter(appCoordinator: appCoordinator)
        let presenter = FavouriteScreenPresenterImpl(likeManager: likeMananger,
                                                     accountMananger: accountManager,
                                                     decoder: decoder,
                                                     contentProvider: contentProvider,
                                                     router: router)
        let viewController = FavouriteScreenViewController(presenter: presenter)
        presenter.setView(viewController)
        router.setViewController(viewController)

        return FavouriteScreenAssembly(view: viewController)
    }

    private init(view: UIViewController) {
        self.viewController = view
    }
}

