//
//  EventsManagerImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 03.01.2023.
//

import Foundation

final class EventsManagerImpl: NetworkManager {
    typealias EventsResult = (data: Data?, response: URLResponse?, error: Error?)
    
    enum EventsStatus {
        case success(data: Data?)
        case error(reason: String?)
    }
    
    private let router: Router<EventsEndPoint>
    private let validationTokenManager: ValidationTokenManager
    
    init(router: Router<EventsEndPoint>, validationTokenManager: ValidationTokenManager) {
        self.router = router
        self.validationTokenManager = validationTokenManager
    }
}

//MARK: Private methods
private extension EventsManagerImpl {
    func getStatusOfEvents(result: EventsResult) -> EventsManagerImpl.EventsStatus {
        switch getStatus(response: result.response) {
        case .success:
            return .success(data: result.data)
        case let .failure(reason):
            return .error(reason: reason)
        }
    }
}

// MARK: EventsManager
extension EventsManagerImpl: EventsManager {
    func getTodayEvents(page: Int) async -> EventsManagerImpl.EventsStatus {
        let token = try? await validationTokenManager.getAccessToken()
        guard let token = token else { return .error(reason: Localizable.no_token()) }
        let result = await router.request(.todayEvents(page: page, token: token))
        return getStatusOfEvents(result: result)
    }
    
    func getCloseEvents(page: Int, lat: Double, lon: Double) async -> EventsManagerImpl.EventsStatus{
        let token = try? await validationTokenManager.getAccessToken()
        guard let token = token else { return .error(reason: Localizable.no_token()) }
        let result = await router.request(.closeEvents(page: page, lat: lat, lon: lon, token: token))
        return getStatusOfEvents(result: result)
    }
    
    func getMainEvents(page: Int) async -> EventsManagerImpl.EventsStatus {
        let token = try? await validationTokenManager.getAccessToken()
        guard let token = token else { return .error(reason: Localizable.no_token()) }
        let result = await router.request(.mainEvents(page: page, token: token))
        return getStatusOfEvents(result: result)
    }
    
    func getEvent(withId id: Int, and placeId: Int) async -> EventsManagerImpl.EventsStatus {
        let token = try? await validationTokenManager.getAccessToken()
        guard let token = token else { return .error(reason: Localizable.no_token()) }
        let result =  await router.request(.event(id: id, placeId: placeId, token: token))
        return getStatusOfEvents(result: result)
    }
}
