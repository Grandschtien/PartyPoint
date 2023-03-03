//
//  EventsPresenter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import Foundation

final class EventsPresenter {
    
	weak var view: EventsViewInput?
    weak var moduleOutput: EventsModuleOutput?
    
	private let router: EventsRouterInput
	private let interactor: EventsInteractorInput
    
    init(router: EventsRouterInput, interactor: EventsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

private extension EventsPresenter {
    func makeSection(withInfo info: [EventInfo],
                     title: String,
                     moreType: MoreEventsType,
                     ofType type: SectionType) -> Section<EventInfo> {
        return Section<EventInfo>(header: title, moreType: moreType, sectionType: type, items: info)
    }
    
    func makeProfileInfo(from model: PPUserInformation) -> ProfileInfo {
        let imageUrl = model.imageUrl ?? ""
        let imageURl = URL(string: imageUrl)
        return ProfileInfo(name: model.name, surname: model.surname, email: model.surname, imageUrl: imageURl)
    }
}

extension EventsPresenter: EventsModuleInput {
}

extension EventsPresenter: EventsViewOutput {
    func eventDisliked(eventId: Int, index: Int, section: SectionType) {
        interactor.eventDisliked(eventId: eventId, index: index, section: section)
    }
    
    func moreTapped(moreType: MoreEventsType) {
        router.openMore(withType: moreType)
    }
    
    func openProfile() {
        interactor.getUserForProfile()
    }
    
    func eventLiked(eventId: Int, index: Int, section: SectionType) {
        interactor.eventLiked(eventId: eventId, index: index, section: section)
    }
    
    func tappedOnEvents(section: SectionType, index: Int) {
        let event: EventInfo
        switch section {
        case .main:
            event = interactor.getMainEventId(withIndex: index)
            router.openEventScreen(withId: event.id, and: event.placeId)
        case .today:
            event = interactor.getTodayEventId(withIndex: index)
            router.openEventScreen(withId: event.id, and: event.placeId)
        case .closest:
            event = interactor.getClosestEventId(withIndex: index)
            router.openEventScreen(withId: event.id, and: event.placeId)
        }
    }
    
    func loadNextPage(_ page: Int) {
        interactor.loadNextPageOfMain(page: page)
    }
    
    func onViewDidLoad() {
        view?.showLoaderView()
        interactor.loadFirstPages()
    }
}

extension EventsPresenter: EventsInteractorOutput {
    func updateViewWithNewLike(eventId: Int) {
        view?.updateViewWithNewLike(eventId: eventId)
    }
    
    func openProfile(withUser user: PPUserInformation) {
        let profileInfo = makeProfileInfo(from: user)
        router.openProfile(with: profileInfo)
    }
    
    func setInitialUserInfo(name: String?, image: String?) {
        view?.setInitialUserInfo(name: name, image: image)
    }
    
    func addNewEventsIntoMainSection(_ events: [EventInfo]) {
        view?.showNewPageInMainSection(with: events)
    }
    
    func updateTodaySection(with events: [EventInfo]) {
        let section = makeSection(withInfo: events, title: Localizable.today(), moreType: .today, ofType: .today)
        view?.hideLoaderView()
        view?.updateTodaySection(with: section)
    }
    
    func updateClosestSection(with events: [EventInfo]) {
        let section = makeSection(withInfo: events, title: Localizable.closest(), moreType: .closest, ofType: .closest)
        view?.hideLoaderView()
        view?.updateClosestSection(with: section)
    }
    
    func updateMainSection(with events: [EventInfo]) {
        let section = makeSection(withInfo: events, title: Localizable.main(), moreType: .main, ofType: .main)
        view?.hideLoaderView()
        view?.updateMainSection(with: section)
    }

    func showError(withReason reason: String) {
        view?.hideLoaderView()
        view?.changeCollectionViewVisibility(isHidden: true)
        view?.updateView(withError: reason)
    }
}
