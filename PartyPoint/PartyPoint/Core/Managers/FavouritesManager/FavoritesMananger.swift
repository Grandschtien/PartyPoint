//
//  FavoritesMananger.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 05.03.2023.
//

import Foundation

protocol FavoritesMananger {
    func loadFavorites(userId: Int) async -> NetworkManager.DefaultResultOfRequest
}
