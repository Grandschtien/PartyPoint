//
//  EventsPresenter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import Foundation

final class EventsPresenter {
    enum SectionType {
        case today
        case closest
        case main
    }
    
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
    func getDateOfEvent(start: Int, end: Int) -> String {
        if start == end {
            return Date(timeIntervalSince1970: TimeInterval(start)).toString()
        } else {
            let startDate = Date(timeIntervalSince1970: TimeInterval(start)).toString()
            let endDate = Date(timeIntervalSince1970: TimeInterval(end)).toString()
            return "\(startDate) - \(endDate)"
        }
    }
    
    func getEventsInfo(events: [PPEvent]) -> [EventInfo] {
        return events.map { event in
            let url = URL(string: event.image)
            let dateOfEvent = getDateOfEvent(start: event.start, end: event.end)
            let capitlizedTitle = event.title.capitalized
            return EventInfo(id: event.kudagoID, title: capitlizedTitle, date: dateOfEvent, image: url)
        }
    }
    
    func makeSection(withInfo info: [EventInfo], ofType type: SectionType) -> Section<EventInfo> {
        switch type {
        case .today:
            return Section<EventInfo>(header: Localizable.today(), items: info)
        case .closest:
            return Section<EventInfo>(header: Localizable.closest(), items: info)
        case .main:
            return Section<EventInfo>(header: Localizable.main(), items: info)
        }
    }
}

extension EventsPresenter: EventsModuleInput {
}

extension EventsPresenter: EventsViewOutput {
    func onViewDidLoad() {
        view?.showLoaderView()
        interactor.loadFirstPages()
    }
}

extension EventsPresenter: EventsInteractorOutput {
    func updateTodaySection(with events: [PPEvent]) {
        let info = getEventsInfo(events: events)
        let section = makeSection(withInfo: info, ofType: .today)
        view?.hideLoaderView()
        view?.updateTodaySection(with: section)
    }
    
    func updateClosestSection(with events: [PPEvent]) {
        let info = getEventsInfo(events: events)
        let section = makeSection(withInfo: info, ofType: .closest)
        view?.hideLoaderView()
        view?.updateClosestSection(with: section)
    }
    
    func updateMainSection(with events: [PPEvent]) {
        let info = getEventsInfo(events: events)
        let section = makeSection(withInfo: info, ofType: .main)
        view?.hideLoaderView()
        view?.updateMainSection(with: section)
    }

    func showError(withReason reason: String) {
        view?.hideLoaderView()
        view?.changeCollectionViewVisibility(isHidden: true)
        view?.updateView(withError: reason)
    }
}
