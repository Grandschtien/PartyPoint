//
//  UniversalLinksManagerImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 09.05.2023.
//

import Foundation

final class UniversalLinksManagerImpl: UniversalLinksManager {
    private let accountManager: PPAccountManager = AccountManangerFabric.assembly()
    
    static let shared: UniversalLinksManager = UniversalLinksManagerImpl()
    
    private init() {}
    
    func hadnleUrlIfNeeded(with userActivity: NSUserActivity?) {
        guard let userActivity = userActivity,
              userActivity.activityType == NSUserActivityTypeBrowsingWeb,
              let incomingURL = userActivity.webpageURL,
              let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true),
              checkAuthorization(),
              let strategy = chooseStrategy(forUrl: components)
        else {
            return
        }
        
        let navigationStrategyManager = NavigationStrategyManager(strategy: strategy)
        navigationStrategyManager.performStrategy()
    }
    
    private func checkAuthorization() -> Bool {
        if accountManager.getUser() != nil {
            return true
        }
        
        return false
    }
    
    private func chooseStrategy(forUrl urlComponents: NSURLComponents) -> NavigationStrategy? {
        guard let path = urlComponents.path else { return nil }
        switch path {
        case _ where path.contains("/api/events/external/"):
            guard let eventInfo = EventInfoParser.parse(path: path) else { return nil }
            return EventNavigationStrategy(placeId: eventInfo.placeId, eventId: eventInfo.eventId)
        default:
            return nil
        }
    }
}
