//
//  EventsContentProviderImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 24.02.2023.
//

import Foundation

final class EventsContentProviderImpl {
    private var mainEvents: [PPEvent] = []
    private var todayEvents: [PPEvent] = []
    private var closestEvents: [PPEvent] = []
}

extension EventsContentProviderImpl: EventsContentProvider {
    func getMainEventId(withIndex index: Int) -> PPEvent {
        return mainEvents[index]
    }
    
    func getClosestEventId(withIndex index: Int) -> PPEvent {
        return closestEvents[index]
    }
    
    func getTodayEventId(withIndex index: Int) -> PPEvent {
        return todayEvents[index]
    }
    
    func getMainEvents() -> [PPEvent] {
        return mainEvents
    }
    
    func getTodayEvents() -> [PPEvent] {
        return todayEvents
    }
    
    func getClosesEvents() -> [PPEvent] {
        return closestEvents
    }
    
    func setMainEvents(_ events: [PPEvent]) {
        mainEvents.append(contentsOf: events)
    }
    
    func setTodayEvents(_ events: [PPEvent]) {
        todayEvents.append(contentsOf: events)
    }
    
    func setClosesEvents(_ events: [PPEvent]) {
        closestEvents.append(contentsOf: events)
    }
    
    func updateLikeState(eventId: Int, index: Int, section: Int) {
        switch section {
        case 0:
            mainEvents[index]
        case 1:
            break
        case 2:
            break
        default:
            break
        }
    }
}
