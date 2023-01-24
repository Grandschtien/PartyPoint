//
//  Event.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 15.07.2022.
//

import Foundation

struct PPEvents: Codable {
    let events: [PPEvent]
}

struct PPEvent: Hashable, Codable {
    let id, kudagoID: Int
    let title: String
    let start, end: Int
    let location: String
    let image: String
    let place: Int
    let description, price: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case kudagoID = "kudago_id"
        case title, start, end, location, image, place, description, price
    }
}
