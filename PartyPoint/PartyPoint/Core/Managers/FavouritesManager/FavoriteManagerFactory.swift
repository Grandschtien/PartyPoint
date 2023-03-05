//
//  FavoriteManagerFactory.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 05.03.2023.
//

import Foundation

class FavoriteManagerFactory {
    class func assembly() -> FavoritesMananger {
        let tokenMananger = TokenManagerFabric.assembly()
        let router = Router<FavoriteEndPoint>()
        return FavoritesManangerImpl(validationTokenMananger: tokenMananger, router: router)
    }
}
