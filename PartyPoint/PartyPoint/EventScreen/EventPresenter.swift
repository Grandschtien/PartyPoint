//
//  EventPresenter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 16.08.2022.
//  
//

import Foundation

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
        let peopleAmount = createPeopleAmountInfo(event: event)
        return EventFullInfo(imageURL: imageURL,
                             title: event.event.title.capitalizedFirst,
                             location: locationInfo,
                             description: event.event.description,
                             cost: cost,
                             peopleAmount: peopleAmount,
                             placeAnnotation: placeAnnotation)
    }
    
    func createPlaceAnnotation(event: PPEventInformation) -> PlaceAnnotationInfo {
        return PlaceAnnotationInfo(title: event.event.title,
                                   locationName: event.place.title,
                                   discipline: nil,
                                   coordinate: event.place.coordinates)
    }
    
    func createCostInfo(event: PPEventInformation) -> CostEventInfo {
        let title = Localizable.cost()
        let cost = event.event.price
        let buttonTitle = Localizable.pay_on_foreign_site()
        let orgURL = URL(string: event.place.siteURL)
        return CostEventInfo(title: title, cost: cost, buttonTitle: buttonTitle, orginazerURL: orgURL)
    }
    
    func createPeopleAmountInfo(event: PPEventInformation) -> PeopleEventnfoModel {
        let title = Localizable.people_amount()
        let amount = "\(event.peopleCount)"
        let buttonTitle = event.isGoing ? Localizable.dont_go() : Localizable.will_go()
        return PeopleEventnfoModel(title: title,
                                   amount: amount,
                                   buttonTitle: buttonTitle,
                                   isGoing: event.isGoing)
    }
    
    func validateDate(start: Date, end: Date) -> (date: String, time: String) {
        let calendar = Calendar.current
        let startDate = start.toString()
        let endDate = end.toString()
        if startDate == endDate {
            let hour = calendar.component(.hour, from: start)
            let minutes = calendar.component(.minute, from: start)
            return (startDate, "\(hour):\(minutes)")
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
        return LocationInfo(address: event.place.address, date: validatatedDate.date, time: validatatedDate.time)
    }
}

extension EventPresenter: EventModuleInput {
}

extension EventPresenter: EventViewOutput {
    func backAction() {
        router.backToPrevController()
    }
    
    func onViewDidLoad() {
        view?.setLoaderVisibility(isHidden: false)
        interactor.loadEvent()
    }
    
    func changeVisibilityOfNavBar(offset: CGFloat) {
        if offset <= 76 {
            let title = interactor.getTitle().capitalizedFirst
            view?.showNavBar(withTitle: title)
        } else {
            view?.hideNavBar()
        }
    }
}

extension EventPresenter: EventInteractorOutput {
    func performWithError(reason: String) {
        view?.setLoaderVisibility(isHidden: true)
        print(reason)
    }
    
    func performWithEvent(event: PPEventInformation) {
        view?.setLoaderVisibility(isHidden: true)
        let infoModel = makeInfoModel(event: event)
        view?.setupView(withInfo: infoModel)
    }
}
