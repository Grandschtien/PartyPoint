//
//  PlaceAnnotationInfo.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 22.01.2023.
//

import MapKit

final class PlaceAnnotationInfo: NSObject, MKAnnotation {
    let title: String?
    let locationName: String?
    let discipline: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?,
         locationName: String?,
         discipline: String?,
         coordinate: PPCoordinates) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = CLLocationCoordinate2D(latitude: coordinate.lat, longitude: coordinate.lon)
    }
}
