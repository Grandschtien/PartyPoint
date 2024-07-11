//
//  MKMapView+Extensions.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 22.01.2023.
//

import MapKit

extension MKMapView {
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 1000
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
    
    func centerToLocation(
        _ location: CLLocationCoordinate2D,
        regionRadius: CLLocationDistance = 1000
    ) {
        let location =  CLLocation(latitude: location.latitude, longitude: location.longitude)
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
    
    func centerToLocation(
        _ coordinates: PPCoordinates,
        regionRadius: CLLocationDistance = 1000
    ) {
        let location = CLLocation(latitude: coordinates.lat, longitude: coordinates.lon)
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
