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
    
    func getMainEventId(withIndex index: Int) -> EventInfo
    func getClosestEventId(withIndex index: Int) -> EventInfo
    func getTodayEventId(withIndex index: Int) -> EventInfo
}
