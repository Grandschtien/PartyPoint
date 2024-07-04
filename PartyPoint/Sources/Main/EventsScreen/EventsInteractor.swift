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
    private let accountManager: PPAccountManager
    private let likeManager: LikeManager
    
    init(eventsManager: EventsManager,
         locationManager: LocationManager,
         decoder: PPDecoder,
         contentProvider: EventsContentProvider,
         accountManager: PPAccountManager,
         likeManager: LikeManager) {
        self.eventsManager = eventsManager
        self.locationManager = locationManager
        self.decoder = decoder
        self.contentProvider = contentProvider
        self.accountManager = accountManager
        self.likeManager = likeManager
        
        likeManager.addListener(self)
    }
    
    deinit  {
        likeManager.removeListener(self)
    }
}

private extension EventsInteractor {
    func getMain(withPage page: Int) async -> (events: [EventInfo]?, reason: String?) {
        let main = await eventsManager.getMainEvents(page: page)
    
        switch main {
        case let .success(data):
            guard let events = makeEvents(data: data) else {
                return (nil, PartyPointStrings.Localizable.couldNotDecodeTheResponse)
            }
            
            let eventInfo = EventsConverter.getEventsInfo(events: events)
            self.contentProvider.setMainEvents(eventInfo)
            return (eventInfo, nil)
        case let .error(reason):
            return (nil, reason)
        }
    }
    
    func getToday() async -> [EventInfo]? {
        let today = await eventsManager.getTodayEvents(page: 1)
    
        switch today {
        case .success(let data):
            guard let events = makeEvents(data: data) else {
                return nil
            }
            
            let eventInfo = EventsConverter.getEventsInfo(events: events)
            self.contentProvider.setTodayEvents(eventInfo)
            return eventInfo
        case .error(_):
            return nil
        }
    }
    
    func getClosest() async -> [EventInfo]? {
        let coordinates = locationManager.getCoordinates()
        let closest: EventsManagerImpl.EventsStatus
        if let lat = coordinates.lat, let lon = coordinates.lon {
            closest = await eventsManager.getCloseEvents(page: 1, lat: lat, lon: lon)
            
            switch closest {
            case .success(let data):
                guard let events = makeEvents(data: data) else {
                    return nil
                }
                
                let eventInfo = EventsConverter.getEventsInfo(events: events)
                self.contentProvider.setClosesEvents(eventInfo)
                return eventInfo
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
    
    func updateClosestCompiliations(withEvents events: [EventInfo]?) async {
        if let events = events {
            await runOnMainThread {
                output?.updateClosestSection(with: events)
            }
        }
    }
    
    func updateTodayCompiliations(withEvents events: [EventInfo]?) async {
        if let events = events {
            await runOnMainThread {
                output?.updateTodaySection(with: events)
            }
        }
    }
    
    func updateMainSection(withEvents events: [EventInfo]?, reason: String?) async {
        await runOnMainThread {
            if let events = events {
                output?.updateMainSection(with: events)
            } else {
                guard let reason = reason else {
                    output?.showError(withReason: PartyPointStrings.Localizable.somthingGoesWrong)
                    return
                }
                output?.showError(withReason: reason)
            }
        }
    }
}

extension EventsInteractor: EventsInteractorInput {
    func eventDisliked(index: Int, section: SectionType) {
        let eventId = contentProvider.getEventId(withIndex: index, section: section)
        
        Task {
            await likeManager.unlikeEvent(withId: eventId)
        }
    }
    
    func getUserForProfile() {
        guard let user = accountManager.getUser() else { return }
        output?.openProfile(withUser: user)
    }
    
    func eventLiked(index: Int, section: SectionType) {
        let eventId = contentProvider.getEventId(withIndex: index, section: section)
        
        Task {
            await likeManager.likeEvent(withId: eventId)
        }
    }
    
    func getEvent(withIndex index: Int, section: SectionType) -> EventInfo {
        return contentProvider.getEvent(withIndex: index, section: section)
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
        let user = accountManager.getUser()
        output?.setInitialUserInfo(name: user?.name, image: user?.imgUrl)
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
    
    func clearEvents() {
        contentProvider.clearContentProvider()
    }
}

extension EventsInteractor: LikeEventListener {
    func likeManager(_ likeManager: LikeManager, didRemoveLikeEvent event: PPEventWrapper?) {
        guard let event = event else { return }
        if contentProvider.isLikedEvent(withId: event.kudagoID) {
            contentProvider.setLikedEvent(withId: event.kudagoID, isLiked: false)
            DispatchQueue.main.async { [self] in
                output?.updateViewWithNewLike(eventId: event.kudagoID)
            }
        }
    }
    
    func likeManager(_ likeManager: LikeManager, didLikeEvent event: PPEventWrapper?) {
        guard let event = event else { return }
        if !contentProvider.isLikedEvent(withId: event.kudagoID) {
            contentProvider.setLikedEvent(withId: event.kudagoID, isLiked: true)
            DispatchQueue.main.async { [self] in
                output?.updateViewWithNewLike(eventId: event.kudagoID)
            }
        }
    }
}
