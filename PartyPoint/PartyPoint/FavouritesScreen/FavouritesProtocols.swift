//
//  FavouritesProtocols.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import Foundation

protocol FavouritesModuleInput {
	var moduleOutput: FavouritesModuleOutput? { get }
}

protocol FavouritesModuleOutput: AnyObject {
}

protocol FavouritesViewInput: AnyObject {
    func showUserInfo(name: String, avatar: String?)
    func updateView(withInfo info: [EventInfo])
    func showNothingLiked()
    func showError(reason: String)
    func setLoaderIfNeeded(isLoading: Bool)
    func removeItem(atIndex index: Int)
}

protocol FavouritesViewOutput: AnyObject {
    func onViewDidLoad()
    func updateView()
    func getUserProfile()
    func tapOnEvent(index: Int)
}

protocol FavouritesInteractorInput: AnyObject {
    func getUserInfo()
    func getUserProfile()
    func loadFavourites()
    func getEventId(withIndex index: Int)
}

protocol FavouritesInteractorOutput: AnyObject {
    func userInfoLoaded(name: String, avatar: String?)
    func openUserProfile(withInfo info: ProfileInfo)
    func dataLoaded(info: [EventInfo])
    func dataIsEmpy()
    func requestFailed(reason: String)
    func openEvent(withId id: Int, placeId: Int)
    func removeEvent(withIndex index: Int)
}

protocol FavouritesRouterInput: AnyObject {
    func openProfileScreen(withInfo info: ProfileInfo)
    func opneEvent(withId id: Int, placeId: Int) 
}
