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
    func onViewDidLoad()
    func changeVisibilityOfNavBar(offset: CGFloat)
}

protocol EventInteractorInput: AnyObject {
    func loadEvent()
    func getTitle() -> String
}

protocol EventInteractorOutput: AnyObject {
    func performWithError(reason: String)
    func performWithEvent(event: PPEventInformation)
}

protocol EventRouterInput: AnyObject {
    func backToPrevController()
}
