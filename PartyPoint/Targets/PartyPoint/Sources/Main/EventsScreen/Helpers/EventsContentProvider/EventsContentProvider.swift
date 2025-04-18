//
//  EventsContentProvider.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 24.02.2023.
//

import Foundation

protocol EventsContentProvider {
    func getMainEvents() -> [EventInfo]
    func getTodayEvents() -> [EventInfo]
    func getClosesEvents() -> [EventInfo]
    
    func setMainEvents(_ events: [EventInfo])
    func setTodayEvents(_ events: [EventInfo])
    func setClosesEvents(_ events: [EventInfo])
    
    func getEventId(withIndex index: Int, section: SectionType) -> Int
    func getEvent(withIndex index: Int, section: SectionType) -> EventInfo
    func setLikedEvent(withIndex index: Int, section: SectionType, isLiked: Bool)
    func setLikedEvent(withId id: Int, isLiked: Bool)

    func isLikedEvent(withId id: Int) -> Bool
    
    func clearContentProvider()
}
