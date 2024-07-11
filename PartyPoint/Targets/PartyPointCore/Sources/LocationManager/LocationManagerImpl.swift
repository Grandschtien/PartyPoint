//
//  LocationManagerImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 03.01.2023.
//

import CoreLocation

public final class LocationManagerImpl: NSObject {
    typealias Coordinates = (Double, Double)
    
    private let locationManager: CLLocationManager
    private var coodinates: Coordinates?
    
    public init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.startUpdateLocationIfCan()
    }
}

extension LocationManagerImpl: LocationManager {
    public func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    public func getCoordinates() -> (lat: Double?, lon: Double?) {
        return (coodinates?.0, coodinates?.1)
    }
}

private extension LocationManagerImpl {
    func startUpdateLocationIfCan() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .denied, .notDetermined, .restricted:
            break
        @unknown default:
            break
        }
    }
}

// MARK: CLLocationManagerDelegate
extension LocationManagerImpl: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        coodinates = (locValue.latitude, locValue.longitude)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Swift.Error) {
        debugPrint("[DEBUG]: Error with location, reason: \(error.localizedDescription)")
    }
}
