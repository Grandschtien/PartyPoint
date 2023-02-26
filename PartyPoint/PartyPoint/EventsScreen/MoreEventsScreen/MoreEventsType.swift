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
    static let today = MoreEventsType(title: Localizable.today())
    static let closest = MoreEventsType(title: Localizable.closest())
    static let main = MoreEventsType(title: Localizable.main())
}
