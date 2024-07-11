//
//  EventProtocols.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 16.08.2022.
//  
//

import Foundation

protocol EventModuleInput {
	var moduleOutput: EventModuleOutput? { get }
}

protocol EventModuleOutput: AnyObject {
}

protocol EventViewInput: AnyObject {
    func setLoaderVisibility(isHidden: Bool)
    func setupView(withInfo info: EventFullInfo)
    func showNavBar()
    func hideNavBar()
}

protocol EventViewOutput: AnyObject {
    func backAction()
    func shareEvent()
    func onViewDidLoad()
    func changeVisibilityOfNavBar(offset: CGFloat)
    func openSuperviserSite()
}

protocol EventInteractorInput: AnyObject {
    func loadEvent()
    func getEventUrl() -> URL?
    func getTitle() -> String
    func getSiteUrl() -> URL?
}

protocol EventInteractorOutput: AnyObject {
    func performWithError(reason: String)
    func performWithEvent(event: PPEventInformation)
}

protocol EventRouterInput: AnyObject {
    func backToPrevController()
    func openSuperviserSite(with url: URL)
    func openShareSheeet(with url: URL)
}
