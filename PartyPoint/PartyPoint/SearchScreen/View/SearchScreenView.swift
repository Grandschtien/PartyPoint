//
//  SearchScreenView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 24.02.2023.
//  
//

protocol SearchScreenView: AnyObject {
    func updateViewWithInitialSearchContent(info: [EventInfo])
    func updateViewWithNewPageOfEvents(info: [EventInfo])
    func needsShowLoader(isLoading: Bool)
    func openEventScreen(withEvent event: EventInfo)
    func setVisibilityOfResultsView(isHidden: Bool)
    func setVisibilityOfEmptyView(isHidden: Bool)
    func setVisibilityOfDefaultView(isHidden: Bool)
}
