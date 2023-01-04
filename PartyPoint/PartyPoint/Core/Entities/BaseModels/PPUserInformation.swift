//
//  PPUserInfo.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 28.12.2022.
//

import Foundation

struct PPUserInformation {
    let email: String
    let id: Int
    let name: String
    let surname: String
}

extension PPUserInformation: Codable {
    enum CodingKeys: String, CodingKey {
        case email
        case id
        case name
        case surname
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.surname = try container.decode(String.self, forKey: .surname)
        self.email = try container.decode(String.self, forKey: .email)
    }
}
