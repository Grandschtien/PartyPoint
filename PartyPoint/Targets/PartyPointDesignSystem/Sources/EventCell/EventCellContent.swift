//
//  EventCellContent.swift
//  PartyPointDesignSystem
//
//  Created by Егор Шкарин on 09.07.2024.
//

import Foundation

public protocol EventCellContent {
    var uid: UUID { get }
    var id: Int { get }
    var placeId: Int { get }
    var title: String { get }
    var date: String { get }
    var image: URL? { get }
    var isLiked: Bool { get set }
}
