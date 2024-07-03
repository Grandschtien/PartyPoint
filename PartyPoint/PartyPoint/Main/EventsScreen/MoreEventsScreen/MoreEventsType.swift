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
    static let today = MoreEventsType(title: R.string.localizable.today())
    static let closest = MoreEventsType(title: R.string.localizable.closest())
    static let main = MoreEventsType(title: R.string.localizable.main())
}
