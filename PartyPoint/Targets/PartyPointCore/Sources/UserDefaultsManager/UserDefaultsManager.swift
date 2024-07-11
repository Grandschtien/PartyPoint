//
//  UserDefaultsManager.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 01.02.2023.
//

import Foundation

public protocol UserDefaultsManager {
    // MARK: IsLogged
    func setIsLogged(_ flag: Bool)
    func getIsLogged() -> Bool
    func removeIsLogged()
}
