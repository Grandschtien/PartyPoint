//
//  PPUserInfo.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 28.12.2022.
//

import Foundation

struct PPUserInformation {
    let id: Int
    let name: String
    let surname: String
    let dateOfBirth: String
    let email: String
    let city: String?
    let about: String?
    let imageUrl: String?
}

extension PPUserInformation: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case surname
        case dateOfBirth
        case city
        case about
        case imageUrl
        case email
    }
}
