//
//  AccountManangerFactory.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 27.02.2023.
//

import Foundation

final class AccountManangerFactory {
    static func assembly() -> PPAccountManager {
        let decoder = PPDecoderImpl()
        let router = Router<UserEndPoint>()
        return PPAccountManagerImpl(decoder: decoder, router: router)
    }
}
