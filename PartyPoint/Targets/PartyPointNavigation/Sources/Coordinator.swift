//
//  Coordinator.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 26.12.2022.
//

import Foundation

@objc public protocol Coordinator: AnyObject {
    func start()
    @objc optional func setAppCoordinator(_ coordinator: Coordinator)
}
