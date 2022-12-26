//
//  EventRouter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 16.08.2022.
//  
//

import UIKit

final class EventRouter: BaseRouter {}

extension EventRouter: EventRouterInput {
    func backToPrevController() {
        pop(animated: true)
    }
}
