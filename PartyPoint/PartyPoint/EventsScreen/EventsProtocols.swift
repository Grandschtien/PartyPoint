//
//  EventsProtocols.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import Foundation

protocol EventsModuleInput {
	var moduleOutput: EventsModuleOutput? { get }
}

protocol EventsModuleOutput: AnyObject {
}

protocol EventsViewInput: AnyObject {
    func updateTodaySection(with section: Section<EventInfo>)
    func updateClosestSection(with section: Section<EventInfo>)
    func updateMainSection(with section: Section<EventInfo>)
    func showNewPageInMainSection(with info: [EventInfo])
    
    func updateView(withError reason: String)
    func changeCollectionViewVisibility(isHidden: Bool)
    func setInitialUserInfo(name: String?, image: String?)
    func updateViewWithNewLike(eventId: Int)

    func showLoaderView()
    func hideLoaderView()
    func showErrorViewIfNeeded(isHidden: Bool)
}

protocol EventsViewOutput: AnyObject {
    func onViewDidLoad()
    func tappedOnEvents(section: SectionType, index: Int)
    func loadNextPage(_ page: Int)
    func eventLiked(index: Int, section: SectionType)
    func eventDisliked(index: Int, section: SectionType)
    func openProfile()
    func moreTapped(moreType: MoreEventsType)
    func tryToReloadData()
}

protocol EventsInteractorInput: AnyObject {
    func loadFirstPages()
    func getEvent(withIndex index: Int, section: SectionType) -> EventInfo
    func loadNextPageOfMain(page: Int)
    func eventLiked(index: Int, section: SectionType)
    func eventDisliked(index: Int, section: SectionType)
    func getUserForProfile()
}

protocol EventsInteractorOutput: AnyObject {
    func updateTodaySection(with events: [EventInfo])
    func updateClosestSection(with events: [EventInfo])
    func updateMainSection(with events: [EventInfo])
    func showError(withReason reason: String)
    func addNewEventsIntoMainSection(_ events: [EventInfo])
    func setInitialUserInfo(name: String?, image: String?)
    func openProfile(withUser user: PPUserInformation)
    func updateViewWithNewLike(eventId: Int)
}

protocol EventsRouterInput: AnyObject {
    func openEventScreen(withId id: Int, and placeId: Int)
    func openProfile(with info: ProfileInfo)
    func openMore(withType type: MoreEventsType)
}
