//
//  FavouritesContainer.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import UIKit

final class FavouritesContainer {
    let input: FavouritesModuleInput
	let viewController: UIViewController
	private(set) weak var router: FavouritesRouterInput!

	static func assemble(with context: FavouritesContext) -> FavouritesContainer {
        let router = FavouritesRouter(appCoordinator: context.appCoordinator)
        let likeManager = LikeManagerImpl.shared
        let accountManager = AccountManangerFabric.assembly()
        let favoritesMananger = FavoriteManagerFactory.assembly()
        let interactor = FavouritesInteractor(likeManager: likeManager, accountMananger: accountManager, favoritesMananger: favoritesMananger, decoder: PPDecoderImpl(), contentProvider: FvoritesContentProviderImpl())
        let presenter = FavouritesPresenter(router: router, interactor: interactor)
		let viewController = FavouritesViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
        router.setViewController(viewController)

		interactor.output = presenter

        return FavouritesContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: FavouritesModuleInput, router: FavouritesRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct FavouritesContext {
    let appCoordinator: AppCoordinator
	weak var moduleOutput: FavouritesModuleOutput?
}
