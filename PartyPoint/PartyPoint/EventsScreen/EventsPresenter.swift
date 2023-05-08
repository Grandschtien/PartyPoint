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
        let imageUrl = model.imgUrl ?? ""
        let imageURl = URL(string: imageUrl)
        return ProfileInfo(name: model.name, surname: model.surname, email: model.email, imageUrl: imageURl)
    }
}

extension EventsPresenter: EventsModuleInput {
}

extension EventsPresenter: EventsViewOutput {
    func eventLiked(index: Int, section: SectionType) {
        interactor.eventLiked(index: index, section: section)
    }
    
    func eventDisliked(index: Int, section: SectionType) {
        interactor.eventDisliked(index: index, section: section)
    }
    
    func moreTapped(moreType: MoreEventsType) {
        router.openMore(withType: moreType)
    }
    
    func openProfile() {
        interactor.getUserForProfile()
    }
    
    func tappedOnEvents(section: SectionType, index: Int) {
        let event = interactor.getEvent(withIndex: index, section: section)
        router.openEventScreen(withId: event.id, and: event.placeId)
    }
    
    func loadNextPage(_ page: Int) {
        interactor.loadNextPageOfMain(page: page)
    }
    
    func onViewDidLoad() {
        view?.showLoaderView()
        interactor.loadFirstPages()
    }
    
    func tryToReloadData() {
        view?.showErrorViewIfNeeded(isHidden: true)
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
        view?.showErrorViewIfNeeded(isHidden: true)
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
        view?.showErrorViewIfNeeded(isHidden: false)
        view?.updateView(withError: reason)
    }
}
