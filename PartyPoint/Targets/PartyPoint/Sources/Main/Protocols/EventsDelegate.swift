//
//  EventsDelegate.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 20.07.2022.
//

/// This delegate needs to handle taps on cell in collection view and  for pagination
protocol EventsDelegate: AnyObject {
    func loadNetxtPage(page: Int)
    func didTapOnEvent(_ event: EventInfo)
}
