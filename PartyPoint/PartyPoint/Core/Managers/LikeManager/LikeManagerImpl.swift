//
//  LikeManagerImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 28.02.2023.
//

import Foundation

final class LikeManagerImpl: NetworkManager {
    // implement observer
    private let tokenMananger: ValidationTokenManager
    private let router: Router<LikesEndPoint>
//    private weak var listeners: [LikeEventListener]? = []
    
    init(tokenMananger: ValidationTokenManager, router: Router<LikesEndPoint>) {
        self.tokenMananger = tokenMananger
        self.router = router
    }

}

extension LikeManagerImpl: LikeManager {
    func likeEvent(withId id: Int) async {
        let token = try? await tokenMananger.getAccessToken()
        guard let token = token else { return }
        let result = await router.request(.likeEvent(eventId: id, token: token))
        switch getStatus(response: result.response) {
        case .success:
            debugPrint("[DEBUG] - like action for event with id: \(id)")
        case let .failure(reason):
            debugPrint("[DEBUG] - like action for event with id: \(id), has failed with reason :\(reason ?? "")")
        }
    }
    
    func unlikeEvent(withId id: Int) async {
        let token = try? await tokenMananger.getAccessToken()
        guard let token = token else { return }
        let result = await router.request(.unlikeEvent(eventId: id, token: token))
        switch getStatus(response: result.response) {
        case .success:
            debugPrint("[DEBUG] - dislike action for event with id: \(id)")
        case let .failure(reason):
            debugPrint("[DEBUG] - dislike action for event with id: \(id), has failed with reason :\(reason ?? "")")
        }
    }
}

