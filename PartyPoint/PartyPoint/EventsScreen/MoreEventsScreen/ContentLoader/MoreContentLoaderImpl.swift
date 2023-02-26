//
//  MoreContentLoaderImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 25.02.2023.
//

import Foundation

final class MoreContentLoaderImpl {
    private let eventsManager: EventsManager
    private let locationManager: LocationManager
    private let decoder: PPDecoder
    private let screenType: MoreEventsType
    
    init(eventsManager: EventsManager, screenType: MoreEventsType, locationManager: LocationManager, decoder: PPDecoder) {
        self.eventsManager = eventsManager
        self.screenType = screenType
        self.locationManager = locationManager
        self.decoder = decoder
    }
}

extension MoreContentLoaderImpl: MoreContentLoader {
    func loadContent(page: Int) async throws -> [PPEvent] {
        switch screenType {
        case .today:
            let status = await eventsManager.getTodayEvents(page: page)
            
            switch status {
            case let .success(data):                
                guard let data = data,
                       let decoded = decoder.parseJSON(from: data, type: PPEvents.self)
                else { throw MoreLoaderError.errorWithLoadingData }
                
                return decoded.events
            case .error:
                throw MoreLoaderError.errorWithLoadingData
            }
            
        case .closest:
            let location = locationManager.getCoordinates()
            guard let lon = location.lon, let lat = location.lat else { throw MoreLoaderError.noCoordinates }
            let status = await eventsManager.getCloseEvents(page: page, lat: lat, lon: lon)
            
            switch status {
            case let .success(data):
                guard let data = data,
                       let decoded = decoder.parseJSON(from: data, type: PPEvents.self)
                else { throw MoreLoaderError.errorWithLoadingData }
                
                return decoded.events
            case .error:
                throw MoreLoaderError.errorWithLoadingData
            }
        default:
            throw MoreLoaderError.errorWithLoadingData
        }
    }
}
