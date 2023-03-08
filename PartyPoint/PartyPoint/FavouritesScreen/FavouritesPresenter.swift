//
//  FavouritesPresenter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import Foundation

final class FavouritesPresenter {
	weak var view: FavouritesViewInput?
    weak var moduleOutput: FavouritesModuleOutput?
    
	private let router: FavouritesRouterInput
	private let interactor: FavouritesInteractorInput
    
    init(router: FavouritesRouterInput, interactor: FavouritesInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension FavouritesPresenter: FavouritesModuleInput {
}

extension FavouritesPresenter: FavouritesViewOutput {
    func getUserProfile() {
        interactor.getUserProfile()
    }
    
    func updateView() {
        
    }
    
    func onViewDidLoad() {
        view?.setLoaderIfNeeded(isLoading: true)
        interactor.getUserInfo()
        interactor.loadFavourites()
    }
}

extension FavouritesPresenter: FavouritesInteractorOutput {
    func openEvent(withId id: Int, placeId: Int) {
        router.opneEvent(withId: id, placeId: placeId)
    }
    
    func removeElement(atIndex index: Int) {
        view?.removeItem(atIndex: index)
    }
    
    func dataLoaded(info: [EventInfo]) {
        view?.setLoaderIfNeeded(isLoading: false)
        view?.updateView(withInfo: info)
    }
    
    func dataIsEmpy() {
        view?.showNothingLiked()
    }
    
    func requestFailed(reason: String) {
        view?.showError(reason: reason)
    }
    
    func openUserProfile(withInfo info: ProfileInfo) {
        router.openProfileScreen(withInfo: info)
    }
    
    func userInfoLoaded(name: String, avatar: String?) {
        view?.showUserInfo(name: name, avatar: avatar)
    }
    
    func tapOnEvent(index: Int) {
        interactor.getEventId(withIndex: index)
    }
    
    func removeEvent(withIndex index: Int) {
        view?.removeItem(atIndex: index)
    }
}
