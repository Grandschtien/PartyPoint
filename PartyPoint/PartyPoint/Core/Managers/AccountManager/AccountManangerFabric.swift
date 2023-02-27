//
//  AccountManangerFabric.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 27.02.2023.
//

import Foundation

final class AccountManangerFabric {
    static func assembly() -> PPAccountManager {
        let decoder = PPDecoderImpl()
        return PPAccountManagerImpl(decoder: decoder)
    }
}
