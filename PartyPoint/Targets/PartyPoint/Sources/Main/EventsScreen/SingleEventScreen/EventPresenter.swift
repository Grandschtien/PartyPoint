//
//  EventPresenter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 16.08.2022.
//  
//

import Foundation
import PartyPointResources

final class EventPresenter {
	weak var view: EventViewInput?
    weak var moduleOutput: EventModuleOutput?
    
	private let router: EventRouterInput
	private let interactor: EventInteractorInput
    
    init(router: EventRouterInput, interactor: EventInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

private extension EventPresenter {
    func makeInfoModel(event: PPEventInformation) -> EventFullInfo {
        let locationInfo = getLocationInfo(fromEvent: event)
        let imageURL = URL(string: event.event.image)
        let placeAnnotation = createPlaceAnnotation(event: event)
        let cost = createCostInfo(event: event)
        return EventFullInfo(imageURL: imageURL,
                             title: event.event.title.capitalizedFirst,
                             location: locationInfo,
                             description: event.event.description.clearFromHTMLTags(),
                             cost: cost,
                             placeAnnotation: placeAnnotation)
    }
    
    func createPlaceAnnotation(event: PPEventInformation) -> PlaceAnnotationInfo {
        return PlaceAnnotationInfo(title: event.event.title,
                                   locationName: event.place.title,
                                   discipline: nil,
                                   coordinate: event.place.coordinates)
    }
    
    func createCostInfo(event: PPEventInformation) -> CostEventInfo {
        let title = PartyPointResourcesStrings.Localizable.cost
        let cost = event.event.price
        let buttonTitle = PartyPointResourcesStrings.Localizable.payOnForeignSite
        let orgURL = URL(string: event.place.siteURL)
        return CostEventInfo(title: title, cost: cost, buttonTitle: buttonTitle, orginazerURL: orgURL)
    }
    
    func validateDate(start: Date, end: Date) -> (date: String, time: String) {
        let startDate = start.toString()
        let endDate = end.toString()
        if startDate == endDate {
            let time = start.toString(format: "HH:mm")
            return (startDate, time)
        } else {
            let timeInStartDate = start.toString(format: "HH:mm")
            let timeInEndDate = end.toString(format: "HH:mm")
            
            return timeInStartDate == timeInEndDate ?  ("\(startDate) - \(endDate)", "\(timeInStartDate)") :  ("\(startDate) - \(endDate)", "\(timeInStartDate) - \(timeInEndDate)")
        }
    }
    
    func getLocationInfo(fromEvent event: PPEventInformation) -> LocationInfo {
        let start = Date(timeIntervalSince1970: TimeInterval(event.event.start))
        let end = Date(timeIntervalSince1970: TimeInterval(event.event.end))
        let validatatedDate = validateDate(start: start, end: end)
        
        return LocationInfo(address: event.place.address, date: validatatedDate.date, time: validatatedDate.time == "00:00" ? "" : validatatedDate.time)
    }
}

extension EventPresenter: EventModuleInput {
}

extension EventPresenter: EventViewOutput {
    func openSuperviserSite() {
        guard let url = interactor.getSiteUrl() else { return }
        router.openSuperviserSite(with: url)
    }
    
    func backAction() {
        router.backToPrevController()
    }
    
    func shareEvent() {
        let url = interactor.getEventUrl()
        guard let url = url else { return }
        router.openShareSheeet(with: url)
    }
    
    func onViewDidLoad() {
        view?.setLoaderVisibility(isHidden: false)
        interactor.loadEvent()
    }
    
    func changeVisibilityOfNavBar(offset: CGFloat) {
        if offset <= 76 {
            view?.showNavBar()
        } else {
            view?.hideNavBar()
        }
    }
}

extension EventPresenter: EventInteractorOutput {
    func performWithError(reason: String) {
        view?.setLoaderVisibility(isHidden: true)
    }
    
    func performWithEvent(event: PPEventInformation) {
        view?.setLoaderVisibility(isHidden: true)
        let infoModel = makeInfoModel(event: event)
        view?.setupView(withInfo: infoModel)
    }
}
