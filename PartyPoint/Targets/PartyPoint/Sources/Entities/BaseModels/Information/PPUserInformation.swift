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
    var city: String = "msk"
    let about: String?
    let imgUrl: String?
}

extension PPUserInformation: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case surname
        case dateOfBirth
        case city
        case about
        case imgUrl
        case email
    }
}
