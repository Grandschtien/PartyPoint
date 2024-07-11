//
//  EventInfoParser.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.05.2023.
//

import Foundation

final class EventInfoParser {
    static func parse(path: String) -> (eventId: Int, placeId: Int)? {
        let eventsIds = path.split(separator: "/").compactMap { Int($0) }
        guard eventsIds.count > 1 else { return nil }
        
        return (eventsIds[1], eventsIds[0])
    }
}
