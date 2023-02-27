//
//  EventsConverter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 26.02.2023.
//

import Foundation

final class EventsConverter {
    static func getDateOfEvent(start: Int, end: Int) -> String {
        let startDate = Date(timeIntervalSince1970: TimeInterval(start)).toString()
        let endDate = Date(timeIntervalSince1970: TimeInterval(end)).toString()
        return startDate == endDate ? startDate : "\(startDate) - \(endDate)"
    }
    
    static func getEventsInfo(events: [PPEvent]) -> [EventInfo] {
        return events.map { event in
            let url = URL(string: event.image)
            let dateOfEvent = getDateOfEvent(start: event.start, end: event.end)
            let capitlizedTitle = event.title.capitalizedFirst
            return EventInfo(id: event.kudagoID, placeId: event.place, title: capitlizedTitle, date: dateOfEvent, image: url, isLiked: event.isLiked)
        }
    }
}
