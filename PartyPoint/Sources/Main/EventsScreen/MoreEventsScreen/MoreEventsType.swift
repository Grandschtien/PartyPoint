//
//  MoreEventsType.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 25.02.2023.
//

import Foundation

struct MoreEventsType {
    let title: String
}

extension MoreEventsType: Equatable {
    static let today = MoreEventsType(title: PartyPointStrings.Localizable.today)
    static let closest = MoreEventsType(title: PartyPointStrings.Localizable.closest)
    static let main = MoreEventsType(title: PartyPointStrings.Localizable.main)
}
