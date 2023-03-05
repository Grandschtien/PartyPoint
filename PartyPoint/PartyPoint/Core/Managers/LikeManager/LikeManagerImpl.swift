//
//  LikeManagerImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 28.02.2023.
//

import Foundation

final class LikeManagerImpl: NetworkManager {
    static let shared: LikeManager = LikeManagerImpl()
    private let tokenMananger: ValidationTokenManager
    private let router: Router<LikesEndPoint>
    private var listeners = ObservableSequence<LikeEventListener>()
    
    private override init() {
        self.tokenMananger = TokenManagerFabric.assembly()
        self.router = Router<LikesEndPoint>()
    }
}

extension LikeManagerImpl: LikeManager {
    func addListener(_ subcriber: LikeEventListener) {
        listeners.addListener(subcriber)
    }
    
    func removeListener(_ subscriber: LikeEventListener) {
        listeners.removeListener(subscriber)
    }
    
    func likeEvent(withId id: Int) async {
        let token = try? await tokenMananger.getAccessToken()
        guard let token = token else { return }
        listeners.forEach { $0.likeManager?(self, willLikeEventWithId: id) }
        let result = await router.request(.likeEvent(eventId: id, token: token))
        await runOnMainThread {
            switch getStatus(response: result.response) {
            case .success:
                debugPrint("[DEBUG] - like action for event with id: \(id)")
                listeners.forEach { $0.likeManager?(self, didLikeEventWithId: id)}
            case let .failure(reason):
                debugPrint("[DEBUG] - like action for event with id: \(id), has failed with reason :\(reason ?? "")")
            }
        }
    }
    
    func unlikeEvent(withId id: Int) async {
        let token = try? await tokenMananger.getAccessToken()
        guard let token = token else { return }
        listeners.forEach { $0.likeManager?(self, willRemoveLikeEventWithId: id) }
        let result = await router.request(.unlikeEvent(eventId: id, token: token))
        await runOnMainThread {
            switch getStatus(response: result.response) {
            case .success:
                debugPrint("[DEBUG] - dislike action for event with id: \(id)")
                listeners.forEach { $0.likeManager?(self, didREmoveLikeEventWithId: id) }
            case let .failure(reason):
                debugPrint("[DEBUG] - dislike action for event with id: \(id), has failed with reason :\(reason ?? "")")
            }
        }
    }
}
