//
//  PPAccountManager.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 02.01.2023.
//

import Foundation

protocol PPAccountManager {
    func setUser(user: PPUserInformation)
    func getUser() -> PPUserInformation?
    func removeUser()
    func parseUserInformation(data: Data?) -> PPUser?
}
