//
//  FavouritesRouter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import UIKit

final class FavouritesRouter: BaseRouter {
    private let appCoordinator: AppCoordinator
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
}

extension FavouritesRouter: FavouritesRouterInput {
    func openProfileScreen(withInfo info: ProfileInfo) {
        let context = ProfileContext(profileInfo: info, appCoordinator: appCoordinator)
        let assembly = ProfileContainer.assemble(with: context)
        push(vc: assembly.viewController, animated: true)
    }
    
    func opneEvent(withId id: Int, placeId: Int) {
        let context = EventContext(eventId: id, placeId: placeId)
        let container = EventContainer.assemble(with: context)
        container.viewController.hidesBottomBarWhenPushed = true
        push(vc: container.viewController, animated: true)
    }
}
