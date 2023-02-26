//
//  MoreEventsView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 25.02.2023.
//  
//

protocol MoreEventsView: AnyObject {
    func setLoaderVisiability(isLoading: Bool)
    func setTitle(_ title: String)
    func update(withEvents evetns: [EventInfo])
    func showError(reason: String)
    func openEvenScreen(eventId: Int, placeId: Int)
}
