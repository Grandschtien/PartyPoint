//
//  MoreEventsType.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 25.02.2023.
//

import Foundation
import PartyPointResources

struct MoreEventsType {
    let title: String
}

extension MoreEventsType: Equatable {
    static let today = MoreEventsType(title:PartyPointResourcesStrings.Localizable.today)
    static let closest = MoreEventsType(title:PartyPointResourcesStrings.Localizable.closest)
    static let main = MoreEventsType(title:PartyPointResourcesStrings.Localizable.main)
}
