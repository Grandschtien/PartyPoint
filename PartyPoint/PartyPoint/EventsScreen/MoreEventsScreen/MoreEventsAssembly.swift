//
//  MoreEventsAssembly.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 25.02.2023.
//  
//

import UIKit
import CoreLocation

final class MoreEventsAssembly {
    
    let viewController: UIViewController

    static func assemble(screenType: MoreEventsType) -> MoreEventsAssembly {
        let contentProvider = MoreContentProviderImpl(screenType: screenType)
        let router = Router<EventsEndPoint>()
        let eventsManager = EventsManagerImpl(router: router)
        let decoder = PPDecoderImpl()
        let systemLocationManager = CLLocationManager()
        let locationManager = LocationManagerImpl(locationManager: systemLocationManager)
        let contentLoader = MoreContentLoaderImpl(eventsManager: eventsManager, screenType: screenType, locationManager: locationManager, decoder: decoder)
        let presenter = MoreEventsPresenterImpl(loader: contentLoader, contentProvider: contentProvider)
        let viewController = MoreEventsViewController(presenter: presenter)
        presenter.setView(viewController)

        return MoreEventsAssembly(view: viewController)
    }

    private init(view: UIViewController) {
        self.viewController = view
    }
}

