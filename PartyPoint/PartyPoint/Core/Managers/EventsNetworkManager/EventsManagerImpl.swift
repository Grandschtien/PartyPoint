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
    
    init(router: Router<EventsEndPoint>) {
        self.router = router
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
        let result = await router.request(.todayEvents(page: page))
        
        return getStatusOfEvents(result: result)
    }
    
    func getCloseEvents(page: Int, lat: Double, lon: Double) async -> EventsManagerImpl.EventsStatus{
        let result = await router.request(.closeEvents(page: page, lat: lat, lon: lon))
        
        return getStatusOfEvents(result: result)
    }
    
    func getMainEvents(page: Int) async -> EventsManagerImpl.EventsStatus{
        let result = await router.request(.mainEvents(page: page))
        
        return getStatusOfEvents(result: result)
    }
    
    func getEvent() async -> EventsManagerImpl.EventsStatus {
        return .error(reason: "")
    }
}
