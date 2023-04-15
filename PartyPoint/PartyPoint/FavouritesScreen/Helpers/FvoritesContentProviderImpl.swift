//
//  FvoritesContentProviderImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 05.03.2023.
//

import Foundation

class FvoritesContentProviderImpl {
    private var favorites: [EventInfo] = []
}

extension FvoritesContentProviderImpl: FavoritesContentProvider {
    func getEvent(withIndex index: Int) -> EventInfo {
        return favorites[index]
    }
    
    func getEvent(byId id: Int) -> EventInfo? {
        return favorites.first { $0.id == id }
    }
    
    func removeItem(withIndex index: Int) {
        favorites.remove(at: index)
    }
    
    func updateContent(withInfo info: [EventInfo]) {
        favorites = info
    }
    
    func appendNewEvent(event: EventInfo) {
        favorites.insert(event, at: 0)
    }
    
    func removeEvent(event: EventInfo) {
        favorites.removeAll { $0.id == event.id }
    }
    
    func removeItemWithId(id: Int) -> Int {
        guard let index = favorites.firstIndex(where: { $0.id == id } ) else { return -1 }
        favorites.remove(at: index)
        return index
    }
    
    func getEvents() -> [EventInfo] {
        return favorites
    }
}
