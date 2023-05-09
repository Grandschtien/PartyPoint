//
//  FavouriteScreenPresenterImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 15.04.2023.
//  
//

import Foundation

final class FavouriteScreenPresenterImpl {
    private weak var view: FavouriteScreenView?
    private let likeManager: LikeManager
    private let accountMananger: PPAccountManager
    private let contentProvider: FavoritesContentProvider
    private let decoder: PPDecoder
    private let router: FavouritesRouter
    
    init(likeManager: LikeManager,
         accountMananger: PPAccountManager,
         decoder: PPDecoder,
         contentProvider: FavoritesContentProvider,
         router: FavouritesRouter) {
        self.likeManager = likeManager
        self.accountMananger = accountMananger
        self.decoder = decoder
        self.contentProvider = contentProvider
        self.router = router
        likeManager.addListener(self)
    }
    
    deinit {
        likeManager.removeListener(self)
    }
}

// MARK: Private methods
private extension FavouriteScreenPresenterImpl {
    func loadFavourites() {
        guard let user = accountMananger.getUser() else { return }
        Task {
            await runOnMainThread {
                view?.setLoaderIfNeeded(isLoading: true)
                view?.showUserInfo(name: user.name, avatar: user.imgUrl)
            }
            
            let data = try? await likeManager.loadFvourites(userId: user.id)
            
            await runOnMainThread {
                view?.setLoaderIfNeeded(isLoading: false)
                guard let data = data else {
                    view?.showError(reason: Localizable.no_connection_title())
                    return
                }
                
                guard let events = decoder.parseJSON(from: data, type: PPEvents.self)?.events, !events.isEmpty else {
                    view?.showNothingLiked()
                    return
                }
                
                var eventsInfo = EventsConverter.getEventsInfo(events: events)
                let likedInThisSession = contentProvider.getEvents()
                
                if !likedInThisSession.isEmpty {
                    eventsInfo = likedInThisSession + eventsInfo
                }
                
                contentProvider.updateContent(withInfo: eventsInfo)
                view?.updateView(withInfo: eventsInfo)
            }
        }
    }
}

// MARK: Public methods
extension FavouriteScreenPresenterImpl {
    func setView(_ view: FavouriteScreenView) {
        self.view = view
    }
}

// MARK: FavouriteScreenPresenter
extension FavouriteScreenPresenterImpl: FavouriteScreenPresenter {
    func onViewDidLoad() {
        loadFavourites()
    }
    
    func getUserProfile() {
        guard let user = accountMananger.getUser() else { return }
        let info = ProfileInfo(user: user)
        router.openProfileScreen(withInfo: info)
    }
    
    func didTapOnEvent(withIndex index: Int) {
        let event = contentProvider.getEvent(withIndex: index)
        router.openEvent(withId: event.id, placeId: event.placeId)
    }
    
    func tryToRefresh() {
        loadFavourites()
    }
    
    func eventDisliked(withIndex index: Int) {
        Task {
            let event = contentProvider.getEvent(withIndex: index)
            await likeManager.unlikeEvent(withId: event.id)
        }
    }
    
    func eventDisliked(eventInfo: EventInfo) {
        Task {
            guard let event = contentProvider.getEvent(byId: eventInfo.id) else { return }
            await likeManager.unlikeEvent(withId: event.id)
        }
    }
}

extension FavouriteScreenPresenterImpl: LikeEventListener {
    func likeManager(_ likeManager: LikeManager, didLikeEvent event: PPEventWrapper?) {
        DispatchQueue.main.async {
            guard let event = event else { return }
            let eventInfo = EventsConverter.getSingleEventInfo(event: event.event)
            self.contentProvider.appendNewEvent(event: eventInfo)
            self.view?.updateWithNewEvent(eventInfo: eventInfo)
        }
    }
    
    func likeManager(_ likeManager: LikeManager, didRemoveLikeEvent event: PPEventWrapper?) {
        DispatchQueue.main.async {
            guard let event = event else { return }
            
            let eventInfo = EventsConverter.getSingleEventInfo(event: event.event)
            self.contentProvider.removeEvent(event: eventInfo)
            
            if self.contentProvider.getEvents().isEmpty {
                self.view?.showNothingLiked()
                self.view?.validateAdatpter()
            } else {
                self.view?.deleteEvent(eventInfo: eventInfo)
            }
        }
    }
}
