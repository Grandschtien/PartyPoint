//
//  EventsInteractor.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import Foundation

final class EventsInteractor {
	weak var output: EventsInteractorOutput?
    private let eventsManager: EventsManager
    private let locationManager: LocationManager
    private let decoder: PPDecoder
    private let contentProvider: EventsContentProvider
    
    init(eventsManager: EventsManager,
         locationManager: LocationManager,
         decoder: PPDecoder,
         contentProvider: EventsContentProvider) {
        self.eventsManager = eventsManager
        self.locationManager = locationManager
        self.decoder = decoder
        self.contentProvider = contentProvider
    }
}

private extension EventsInteractor {
    func getMain(withPage page: Int) async -> (events: [PPEvent]?, reason: String?) {
        let main = await eventsManager.getMainEvents(page: page)
    
        switch main {
        case let .success(data):
            guard let events = makeEvents(data: data) else {
                return (nil, Localizable.could_not_decode_the_response())
            }
            
            self.contentProvider.setMainEvents(events)
            return (events, nil)
        case let .error(reason):
            return (nil, reason)
        }
    }
    
    func getToday() async -> [PPEvent]? {
        let today = await eventsManager.getTodayEvents(page: 1)
    
        switch today {
        case .success(let data):
            guard let events = makeEvents(data: data) else {
                return nil
            }
            
            self.contentProvider.setTodayEvents(events)
            return events
        case .error(_):
            return nil
        }
    }
    
    func getClosest() async -> [PPEvent]? {
        let coordinates = locationManager.getCoordinates()
        let closest: EventsManagerImpl.EventsStatus
        if let lat = coordinates.lat, let lon = coordinates.lon {
            closest = await eventsManager.getCloseEvents(page: 1, lat: lat, lon: lon)
            
            switch closest {
            case .success(let data):
                guard let events = makeEvents(data: data) else {
                    return nil
                }
                
                self.contentProvider.setClosesEvents(events)
                return events
            case .error(_):
                return nil
            }
        } else {
            return nil
        }
    }
    
    func makeEvents(data: Data?) -> [PPEvent]? {
        guard let data = data else { return nil }
        let decoded = decoder.parseJSON(from: data, type: PPEvents.self)
        return decoded?.events
    }
    
    func updateClosestCompiliations(withEvents events: [PPEvent]?) async {
        if let events = events {
            await runOnMainThread {
                output?.updateClosestSection(with: events)
            }
        }
    }
    
    func updateTodayCompiliations(withEvents events: [PPEvent]?) async {
        if let events = events {
            await runOnMainThread {
                output?.updateTodaySection(with: events)
            }
        }
    }
    
    func updateMainSection(withEvents events: [PPEvent]?, reason: String?) async {
        await runOnMainThread {
            if let events = events {
                output?.updateMainSection(with: events)
            } else {
                guard let reason = reason else {
                    output?.showError(withReason: Localizable.somthing_goes_wrong())
                    return
                }
                output?.showError(withReason: reason)
            }
        }
    }
}

extension EventsInteractor: EventsInteractorInput {
    func eventLiked(eventId: Int, index: Int, section: Int) {
        
    }
    
    func getMainEventId(withIndex index: Int) -> PPEvent {
        return contentProvider.getMainEventId(withIndex: index)
    }
    
    func getClosestEventId(withIndex index: Int) -> PPEvent {
        return contentProvider.getClosestEventId(withIndex: index)
    }
    
    func getTodayEventId(withIndex index: Int) -> PPEvent {
        return contentProvider.getTodayEventId(withIndex: index)
    }
    
    func loadFirstPages() {
        Task {
            let today = await getToday()
            await updateTodayCompiliations(withEvents: today)

            let closest = await getClosest()
            await updateClosestCompiliations(withEvents: closest)

            let main = await getMain(withPage: 1)
            await updateMainSection(withEvents: main.events, reason: main.reason)
        }
    }
    
    func loadNextPageOfMain(page: Int) {
        Task {
            let main = await getMain(withPage: page)
            if let evetns = main.events {
                await runOnMainThread {
                    output?.addNewEventsIntoMainSection(evetns)
                }
            }
        }
    }
}
