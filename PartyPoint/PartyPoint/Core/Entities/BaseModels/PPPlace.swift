//
//  PPPlace.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 10.01.2023.
//

import Foundation

struct PPPlace: Codable {
    let title, address: String
    let siteURL: String
    let foreignURL: String
    let coordinates: PPCoordinates

    enum CodingKeys: String, CodingKey {
        case title, address
        case siteURL = "site_url"
        case foreignURL = "foreign_url"
        case coordinates = "coords"
    }
}
