//
//  MoreContentProvider.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 25.02.2023.
//

import Foundation

protocol MoreContentProvider {
    func getEvent(withIndex index: Int) -> EventInfo
    func likeEvent(withIndex index: Int)
    func appendEvents(_ events: [EventInfo])
    var title: String { get }
}
