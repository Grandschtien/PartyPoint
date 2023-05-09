//
//  FavoritesContentProvider.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 05.03.2023.
//

import Foundation

protocol FavoritesContentProvider {
    func getEvent(withIndex index: Int) -> EventInfo
    func removeItem(withIndex index: Int)
    func updateContent(withInfo info: [EventInfo])
    func appendNewContent(info: [EventInfo])
    func removeItemWithId(id: Int) -> Int
    func appendNewEvent(event: EventInfo)
    func removeEvent(event: EventInfo)
    func getEvents() -> [EventInfo]
    func getEvent(byId id: Int) -> EventInfo? 
}
