//
//  EventFullInfo.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 10.01.2023.
//

import Foundation

struct EventFullInfo {
    let imageURL: URL?
    let title: String
    let location: LocationInfo
    let description: String
    let cost: CostEventInfo
    let peopleAmount: PeopleEventnfoModel
    let placeAnnotation: PlaceAnnotationInfo
}
