//
//  EventUrlBuilder.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.05.2023.
//

import Foundation

final class EventUrlBuilder {
    static func buidURL(placeId: Int?, eventId: Int?) -> URL? {
        guard let placeId = placeId, let eventId = eventId else { return nil }
        let baseURLString = "https://diplomatest.site/api/events/external/\(placeId)/\(eventId)"
        return URL(string: baseURLString)
    }
}
