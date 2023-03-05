//
//  FavouritesInteractor.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import Foundation

final class FavouritesInteractor {
	weak var output: FavouritesInteractorOutput?
    private let likeManager: LikeManager
    private let favoritesMananger: FavoritesMananger
    private let accountMananger: PPAccountManager
    private let contentProvider: FavoritesContentProvider
    private let decoder: PPDecoder
    
    init(likeManager: LikeManager,
         accountMananger: PPAccountManager,
         favoritesMananger: FavoritesMananger,
         decoder: PPDecoder, contentProvider: FavoritesContentProvider) {
        self.likeManager = likeManager
        self.accountMananger = accountMananger
        self.favoritesMananger = favoritesMananger
        self.decoder = decoder
        self.contentProvider = contentProvider
        likeManager.addListener(self)
    }
    
    deinit {
        likeManager.removeListener(self)
    }
}

private extension FavouritesInteractor {
    func makeEvents(data: Data?) -> [PPEvent]? {
        guard let data = data else { return nil }
        let decoded = decoder.parseJSON(from: data, type: PPEvents.self)
        return decoded?.events
    }
    
    func performDataLoaded(data: Data?){
        guard let events = makeEvents(data: data) else {
            output?.dataIsEmpy()
            return
        }
        
        let eventInfo = EventsConverter.getEventsInfo(events: events)
        contentProvider.updateContent(withInfo: eventInfo)
        if eventInfo.isEmpty {
            output?.dataIsEmpy()
        } else {
            output?.dataLoaded(info: eventInfo)
        }
    }
}

extension FavouritesInteractor: FavouritesInteractorInput {
    func getUserProfile() {
        guard let user = accountMananger.getUser() else { return }
        let info = ProfileInfo(user: user)
        output?.openUserProfile(withInfo: info)
    }
    
    func loadFavourites() {
        guard let user = accountMananger.getUser() else { return }
        
        Task {
            let result = await favoritesMananger.loadFavorites(userId: user.id)
            
            await runOnMainThread {
                switch result {
                case let .success(data):
                    performDataLoaded(data: data)
                case let .failure(reason):
                    guard let reason = reason else {
                        output?.requestFailed(reason: Localizable.somthing_goes_wrong())
                        return
                    }
                    output?.requestFailed(reason: reason)
                }
            }
        }
    }
    
    func getUserInfo() {
        guard let user = accountMananger.getUser() else { return }
        output?.userInfoLoaded(name: user.name, avatar: user.imageUrl)
    }
    
    func getEventId(withIndex index: Int) {
        let event = contentProvider.getEvent(withIndex: index)
        output?.openEvent(withId: event.id, placeId: event.placeId)
    }
}

extension FavouritesInteractor: LikeEventListener {
    func likeManager(_ likeManager: LikeManager, didREmoveLikeEventWithId id: Int) {
        print(id)
    }
    
    func likeManager(_ likeManager: LikeManager, didLikeEventWithId id: Int) {
        print(id)
    }
}
