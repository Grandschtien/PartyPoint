//
//  PPToken.swift
//  PartyPointCore
//
//  Created by Егор Шкарин on 09.07.2024.
//

import Foundation

struct PPToken {
    let accessToken: String
    let refreshToken: String
    
    static let kTokensKeyChain = "user_tokens"
}

extension PPToken: Codable {
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.accessToken = try container.decode(String.self, forKey: .accessToken)
        self.refreshToken = try container.decode(String.self, forKey: .refreshToken)
    }
}
