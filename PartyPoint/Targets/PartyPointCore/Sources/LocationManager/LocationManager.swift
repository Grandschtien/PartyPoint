//
//  LocationManager.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 03.01.2023.
//

import Foundation

public protocol LocationManager: AnyObject {
    func getCoordinates() -> (lat: Double?, lon: Double?)
    func requestPermission()
}
