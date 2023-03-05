//
//  FavoritesManangerImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 05.03.2023.
//

import Foundation

final class FavoritesManangerImpl: NetworkManager {
    private let validationTokenMananger: ValidationTokenManager
    private let router: Router<FavoriteEndPoint>
    
    init(validationTokenMananger: ValidationTokenManager, router: Router<FavoriteEndPoint>) {
        self.validationTokenMananger = validationTokenMananger
        self.router = router
    }
}

extension FavoritesManangerImpl: FavoritesMananger {
    func loadFavorites(userId: Int) async -> DefaultResultOfRequest {
        let token = try? await validationTokenMananger.getAccessToken()
        guard let token = token else { return .failure(Localizable.no_token()) }
        let result = await router.request(.getFavourites(userId: userId, token: token))
        
        switch getStatus(response: result.response) {
        case .success:
            return .success(result.data)
        case let .failure(reason):
            return .failure(reason)
        }
    }
}
