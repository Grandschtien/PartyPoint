//
//  EventNavigationStrategy.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.05.2023.
//

import Foundation
import UIKit


final class EventNavigationStrategy: NavigationStrategy {
    private let placeId: Int
    private let evetnId: Int
    
    init(placeId: Int, eventId: Int) {
        self.placeId = placeId
        self.evetnId = eventId
    }
    
    func openScreen() {
        let context = EventContext(eventId: evetnId, placeId: placeId)
        let assembly = EventContainer.assemble(with: context)
        
        UIApplication.open(viewController: assembly.viewController)
    }
}
