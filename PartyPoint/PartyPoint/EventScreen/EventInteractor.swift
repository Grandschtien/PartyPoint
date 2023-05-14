//
//  EventInteractor.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 16.08.2022.
//  
//

import Foundation

final class EventInteractor {
    weak var output: EventInteractorOutput?
    private let eventId: Int
    private let placeId: Int
    private let eventsManager: EventsManager
    private let decoder: PPDecoder
    
    private var eventInformation: PPEventInformation?
    
    init(eventId: Int,
         placeId: Int,
         eventsManager: EventsManager,
         decoder: PPDecoder) {
        self.eventId = eventId
        self.placeId = placeId
        self.eventsManager = eventsManager
        self.decoder = decoder
    }
}

private extension EventInteractor {
    func performWithEvent(data: Data?) {
        guard let data = data else {
            output?.performWithError(reason: Localizable.response_returned_with_no_data_to_decode())
            return
        }
        
        let event = decoder.parseJSON(from: data, type: PPEventInformation.self)
        guard let event = event else {
            output?.performWithError(reason: Localizable.could_not_decode_the_response())
            return
        }
        eventInformation = event
        output?.performWithEvent(event: event)
    }
    
    func performWithError(reason: String?) {
        guard let reason = reason else {
            output?.performWithError(reason: Localizable.somthing_goes_wrong())
            return
        }
        output?.performWithError(reason: reason)
    }
}

extension EventInteractor: EventInteractorInput {
    func getEventUrl() -> URL? {
        return EventUrlBuilder.buidURL(placeId: eventInformation?.place.kudaGoID, eventId: eventInformation?.event.kudagoID)
    }
    
    func loadEvent() {
        Task {
            let eventStatus = await eventsManager.getEvent(withId: eventId, and: placeId)
            await runOnMainThread {
                switch eventStatus {
                case let .success(data):
                    performWithEvent(data: data)
                case let .error(reason):
                    performWithError(reason: reason)
                }
            }
        }
    }
    
    func getTitle() -> String {
        return eventInformation?.event.title ?? ""
    }
    
    func getSiteUrl() -> URL? {
        return URL(string: eventInformation?.place.siteURL ?? "")
    }
}
