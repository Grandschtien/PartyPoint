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
    func removeItemWithId(id: Int) -> Int 
}
