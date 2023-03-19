//
//  EventsRouter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import UIKit

final class EventsRouter: BaseRouter {
    private let appCoordinator: AppCoordinator
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
}

extension EventsRouter: EventsRouterInput {
    func openEventScreen(withId id: Int, and placeId: Int){
        let context = EventContext(eventId: id, placeId: placeId)
        let container = EventContainer.assemble(with: context)
        push(vc: container.viewController, animated: true)
    }
    
    func openProfile(with info: ProfileInfo) {
        let context = ProfileContext(profileInfo: info, appCoordinator: appCoordinator)
        let assembly = ProfileContainer.assemble(with: context)
        push(vc: assembly.viewController, animated: true)
    }
    
    func openMore(withType type: MoreEventsType) {
        let assembly = MoreEventsAssembly.assemble(screenType: type)
        push(vc: assembly.viewController, animated: true)
    }
}
