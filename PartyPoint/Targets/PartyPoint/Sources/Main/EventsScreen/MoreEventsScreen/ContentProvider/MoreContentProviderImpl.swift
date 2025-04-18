//
//  MoreContentProviderImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 25.02.2023.
//

import Foundation

final class MoreContentProviderImpl {
    private var events: [EventInfo] = []
    private let screenType: MoreEventsType
    
    init(screenType: MoreEventsType) {
        self.screenType = screenType
    }
}

extension MoreContentProviderImpl: MoreContentProvider {
    func setLikeEvent(isLiked: Bool, withIndex index: Int) {
        events[index].isLiked = isLiked
    }
    
    func likeEvent(withIndex index: Int) {
        events[index].isLiked = true
    }
    
    func getEvent(withIndex index: Int) -> EventInfo {
        return events[index]
    }
    
    func appendEvents(_ events: [EventInfo]) {
        self.events.append(contentsOf: events)
    }
    
    var title: String {
        return screenType.title
    }
}
