//
//  EventInfo.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 04.01.2023.
//

import Foundation
import PartyPointDesignSystem

struct EventInfo: Hashable, EventCellContent {
    let uid = UUID()
    let id: Int
    let placeId: Int
    let title: String
    let date: String
    let image: URL?
    var isLiked: Bool
}
