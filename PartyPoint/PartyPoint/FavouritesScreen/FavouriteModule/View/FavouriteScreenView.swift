//
//  FavouriteScreenView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 15.04.2023.
//  
//

protocol FavouriteScreenView: AnyObject {
    func setLoaderIfNeeded(isLoading: Bool)
    func isNoConnectionViewNeeded(isHidden: Bool)
    func updateView(withInfo info: [EventInfo])
    func showNothingLiked()
    func showError(reason: String)
    func showUserInfo(name: String, avatar: String?)
    func updateWithNewEvent(eventInfo: EventInfo)
    func deleteEvent(eventInfo: EventInfo)
    func validateAdatpter() 
}
