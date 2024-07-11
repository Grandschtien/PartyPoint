//
//  PPPlace.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 10.01.2023.
//

import Foundation

struct PPPlace: Codable {
    let id: Int
    let kudaGoID: Int
    let title, address: String
    let siteURL: String
    let foreignURL: String
    let phone: String
    let timeTable: String
    let coordinates: PPCoordinates

    enum CodingKeys: String, CodingKey {
        case id, title, address, phone
        case kudaGoID = "kudago_id"
        case siteURL = "site_url"
        case foreignURL = "foreign_url"
        case coordinates = "coords"
        case timeTable = "timetable"
    }
}
