//
//  PPEventInformation.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 10.01.2023.
//

import Foundation

struct PPEventInformation: Codable {
    let event: PPEvent
    let place: PPPlace
    let peopleCount: Int
    let isGoing, isFavourite: Bool
    
    enum CodingKeys: String, CodingKey {
        case event, place, peopleCount
        case isGoing = "is_going"
        case isFavourite = "is_favourite"
    }
}
