//
//  TokenInfo.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 02.01.2023.
//

import Foundation

struct TokenInfo: Codable {
    let expireDate: Date
    let accessToken: String
    let refreshToken: String
    
    var isValid: Bool {
        return Date().timeIntervalSince1970 < expireDate.timeIntervalSince1970
    }
    
    init(tokens: PPToken, expireDate: Date) {
        self.refreshToken = tokens.refreshToken
        self.accessToken = tokens.accessToken
        self.expireDate = expireDate
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.expireDate = try container.decode(Date.self, forKey: .expireDate)
        self.accessToken = try container.decode(String.self, forKey: .accessToken)
        self.refreshToken = try container.decode(String.self, forKey: .refreshToken)
    }
}
