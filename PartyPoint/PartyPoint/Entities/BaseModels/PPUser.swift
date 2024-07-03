//
//  PPUser.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 28.12.2022.
//

import Foundation

struct PPUser {
    let tokens: PPToken
    let user: PPUserInformation
}


extension PPUser: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.user = try container.decode(PPUserInformation.self, forKey: .user)
        self.tokens = try container.decode(PPToken.self, forKey: .tokens)
    }
    
    enum CodingKeys: String, CodingKey {
        case user
        case tokens
    }
}
