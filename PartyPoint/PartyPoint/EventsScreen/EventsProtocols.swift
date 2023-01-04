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
    
    func updateView(withError reason: String)
    func changeCollectionViewVisibility(isHidden: Bool)
    
    func showLoaderView()
    func hideLoaderView()
}

protocol EventsViewOutput: AnyObject {
    func onViewDidLoad()
}

protocol EventsInteractorInput: AnyObject {
    func loadFirstPages()
}

protocol EventsInteractorOutput: AnyObject {
    func updateTodaySection(with events: [PPEvent])
    func updateClosestSection(with events: [PPEvent])
    func updateMainSection(with events: [PPEvent])
    func showError(withReason reason: String)
}

protocol EventsRouterInput: AnyObject {
}
