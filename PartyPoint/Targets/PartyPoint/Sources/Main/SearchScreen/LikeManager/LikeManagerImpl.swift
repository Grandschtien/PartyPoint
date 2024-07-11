//
//  LikeManagerImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 28.02.2023.
//

import Foundation
import PartyPointNetworking
import PartyPointCore

final class LikeManagerImpl: NetworkManager {
    static let shared: LikeManager = LikeManagerImpl()
    private let tokenMananger: ValidationTokenManager
    private let router: Router<LikesEndPoint>
    private var listeners = ObservableSequence<LikeEventListener>()
    private let decoder: PPDecoder
    private let dispatchQueue = DispatchQueue(label: "com.PartyPoint.LikeManagerImpl", attributes: .concurrent)
    
    private override init() {
        self.tokenMananger = TokenManagerFactory.assembly()
        self.router = Router<LikesEndPoint>()
        self.decoder = PPDecoderImpl()
    }
    
    private func getEventWrapper(data: Data?) -> PPEventWrapper? {
        guard let data = data,
              let event = decoder.parseJSON(from: data, type: PPEvent.self)
        else { return nil }
        return PPEventWrapper(event: event)
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
        dispatchQueue.async(flags: .barrier) { [self] in
            Task {
                let result = await router.request(.likeEvent(eventId: id, token: token))
                switch getStatus(response: result.response) {
                case .success:
                    debugPrint("[DEBUG] - like action for event with id: \(id)")
                    let eventWrapper = getEventWrapper(data: result.data)
                    listeners.forEach { $0.likeManager?(self, didLikeEvent: eventWrapper)}
                case let .failure(reason):
                    debugPrint("[DEBUG] - like action for event with id: \(id), has failed with reason :\(reason ?? "")")
                }
            }
        }
    }
    
    func unlikeEvent(withId id: Int) async {
        let token = try? await tokenMananger.getAccessToken()
        guard let token = token else { return }
        
        listeners.forEach { $0.likeManager?(self, willRemoveLikeEventWithId: id) }
        dispatchQueue.async(flags: .barrier) { [self] in
            Task {
                let result = await router.request(.unlikeEvent(eventId: id, token: token))
                switch getStatus(response: result.response) {
                case .success:
                    debugPrint("[DEBUG] - dislike action for event with id: \(id)")
                    let eventWrapper = getEventWrapper(data: result.data)
                    listeners.forEach { $0.likeManager?(self, didRemoveLikeEvent: eventWrapper) }
                case let .failure(reason):
                    debugPrint("[DEBUG] - dislike action for event with id: \(id), has failed with reason :\(reason ?? "")")
                }
            }
        }
    }
    
    func loadFvourites(page: Int, userId id: Int) async throws -> Data {
        do {
            let token = try await tokenMananger.getAccessToken()
            let result = await router.request(.getFavourites(page: page, userId: id, token: token))
            guard let data = result.data else { throw NetworkError.emptyData }
            if let error = result.error { throw error }
            return data
        } catch ValidationTokenErrors.noSavedTokens {
            throw ValidationTokenErrors.noSavedTokens
        } catch ValidationTokenErrors.cannotRefreshToken  {
            throw ValidationTokenErrors.cannotRefreshToken
        } catch ValidationTokenErrors.invalidData {
            throw ValidationTokenErrors.invalidData
        } catch {
            throw error
        }
    }
}

