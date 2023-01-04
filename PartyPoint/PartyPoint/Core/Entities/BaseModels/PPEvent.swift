//
//  Event.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 15.07.2022.
//

import Foundation

struct PPEvents: Codable {
    let events: [PPEvent]
    
    enum CodingKeys: String, CodingKey {
        case events = "Events"
    }
}

struct PPEvent: Hashable, Codable {
    let id, kudagoID: Int
    let title: String
    let start, end: Int
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case kudagoID = "kudago_id"
        case title, start, end, image
    }
}
