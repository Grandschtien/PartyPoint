//
//  PPEventWrapper.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 25.03.2023.
//

import Foundation

@objc class PPEventWrapper: NSObject {
    let event: PPEvent
    
    @objc var id: Int
    @objc var kudagoID: Int
    @objc var title: String
    @objc var start: Int
    @objc var end: Int
    @objc var location: String
    @objc var image: String
    @objc var place: Int
    @objc var eventDescription: String
    @objc var price: String
    @objc var isLiked: Bool
    
    init(event: PPEvent) {
        self.event = event
        self.id = event.id
        self.kudagoID = event.kudagoID
        self.title = event.title
        self.start = event.start
        self.end = event.end
        self.location = event.location
        self.image = event.image
        self.place = event.place
        self.eventDescription = event.description
        self.price = event.price
        self.isLiked = event.isLiked
    }
}
