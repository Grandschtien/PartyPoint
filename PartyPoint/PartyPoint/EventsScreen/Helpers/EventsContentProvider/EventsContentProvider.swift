//
//  EventsContentProvider.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 24.02.2023.
//

import Foundation

protocol EventsContentProvider {
    func getMainEvents() -> [PPEvent]
    func getTodayEvents() -> [PPEvent]
    func getClosesEvents() -> [PPEvent]
    
    func setMainEvents(_ events: [PPEvent])
    func setTodayEvents(_ events: [PPEvent])
    func setClosesEvents(_ events: [PPEvent])
    
    func getMainEventId(withIndex index: Int) -> PPEvent
    func getClosestEventId(withIndex index: Int) -> PPEvent
    func getTodayEventId(withIndex index: Int) -> PPEvent
    
    func updateLikeState(eventId: Int, index: Int, section: Int)
}
