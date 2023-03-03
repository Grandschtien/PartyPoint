//
//  EventsContentProviderImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 24.02.2023.
//

import Foundation

final class EventsContentProviderImpl {
    private var mainEvents: [EventInfo] = []
    private var todayEvents: [EventInfo] = []
    private var closestEvents: [EventInfo] = []
}

extension EventsContentProviderImpl: EventsContentProvider {
    func getMainEventId(withIndex index: Int) -> EventInfo {
        return mainEvents[index]
    }
    
    func getClosestEventId(withIndex index: Int) -> EventInfo {
        return closestEvents[index]
    }
    
    func getTodayEventId(withIndex index: Int) -> EventInfo {
        return todayEvents[index]
    }
    
    func getMainEvents() -> [EventInfo] {
        return mainEvents
    }
    
    func getTodayEvents() -> [EventInfo] {
        return todayEvents
    }
    
    func getClosesEvents() -> [EventInfo] {
        return closestEvents
    }
    
    func setMainEvents(_ events: [EventInfo]) {
        mainEvents.append(contentsOf: events)
    }
    
    func setTodayEvents(_ events: [EventInfo]) {
        todayEvents.append(contentsOf: events)
    }
    
    func setClosesEvents(_ events: [EventInfo]) {
        closestEvents.append(contentsOf: events)
    }
}
