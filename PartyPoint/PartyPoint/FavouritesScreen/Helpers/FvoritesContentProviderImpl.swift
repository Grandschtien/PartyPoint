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
    
    func removeItem(withIndex index: Int) {
        favorites.remove(at: index)
    }
    
    func updateContent(withInfo info: [EventInfo]) {
        favorites = info
    }
    
    func removeItemWithId(id: Int) -> Int {
        guard let index = favorites.firstIndex(where: { $0.id == id } ) else { return -1 }
        favorites.remove(at: index)
        return index
    }
}
