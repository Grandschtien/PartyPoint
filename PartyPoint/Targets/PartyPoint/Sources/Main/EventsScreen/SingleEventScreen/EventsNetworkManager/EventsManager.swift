//
//  EventsManager.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 03.01.2023.
//

import Foundation

protocol EventsManager {
    func getTodayEvents(page: Int) async -> EventsManagerImpl.EventsStatus
    func getCloseEvents(page: Int, lat: Double, lon: Double) async -> EventsManagerImpl.EventsStatus
    func getMainEvents(page: Int) async -> EventsManagerImpl.EventsStatus
    func getEvent(withId id: Int, and placeId: Int) async -> EventsManagerImpl.EventsStatus 
}
