//
//  EventsRouter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import UIKit

final class EventsRouter: BaseRouter {}

extension EventsRouter: EventsRouterInput {
    func openEventScreen(withId id: Int, and placeId: Int){
        let context = EventContext(eventId: id, placeId: placeId)
        let container = EventContainer.assemble(with: context)
        container.viewController.hidesBottomBarWhenPushed = true
        push(vc: container.viewController, animated: true)
    }
}
