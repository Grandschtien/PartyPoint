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
    func getEventId(withIndex index: Int, section: SectionType) -> Int {
        switch section {
        case .today:
            return todayEvents[index].id
        case .closest:
            return closestEvents[index].id
        case .main:
            return mainEvents[index].id
        }
    }
    
    func getEvent(withIndex index: Int, section: SectionType) -> EventInfo {
        switch section {
        case .today:
            return todayEvents[index]
        case .closest:
            return closestEvents[index]
        case .main:
            return mainEvents[index]
        }
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
    
    func setLikedEvent(withIndex index: Int, section: SectionType, isLiked: Bool) {
        switch section {
        case .today:
            todayEvents[index].isLiked = isLiked
        case .closest:
            closestEvents[index].isLiked = isLiked
        case .main:
            mainEvents[index].isLiked = isLiked
        }
    }
    
    func setLikedEvent(withId id: Int, isLiked: Bool) {
        for index in mainEvents.indices {
            if mainEvents[index].id == id {
                mainEvents[index].isLiked = isLiked
            }
        }
        
        for index in closestEvents.indices {
            if closestEvents[index].id == id {
                closestEvents[index].isLiked = isLiked
            }
        }
        
        for index in todayEvents.indices {
            if todayEvents[index].id == id {
                todayEvents[index].isLiked = isLiked
            }
        }
    }
    
    func isLikedEvent(withId id: Int) -> Bool {
        var event = mainEvents.first(where: { $0.id == id })
        if let event = event { return event.isLiked }
        event = todayEvents.first(where: { $0.id == id })
        if let event = event { return event.isLiked }
        event = closestEvents.first(where: { $0.id == id })
        if let event = event { return event.isLiked }

        return false
    }
    
    func clearContentProvider() {
        mainEvents.removeAll()
        todayEvents.removeAll()
        closestEvents.removeAll()
    }
}
