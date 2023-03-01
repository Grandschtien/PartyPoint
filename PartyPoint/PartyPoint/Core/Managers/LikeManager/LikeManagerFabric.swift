//
//  LikeManagerFabric.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 28.02.2023.
//

import Foundation

final class LikeManagerFabric {
    static func assembly() -> LikeManager {
        let router = Router<LikesEndPoint>()
        let tokenMananger = TokenManagerFabric.assembly()
        return LikeManagerImpl(tokenMananger: tokenMananger, router: router)
    }
}
