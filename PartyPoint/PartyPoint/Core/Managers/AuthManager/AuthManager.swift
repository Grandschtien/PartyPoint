//
//  AuthManager.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.11.2022.
//

import Foundation

protocol AuthManager {
    func login(with login: String, password: String) async -> AuthManagerImpl.AuthStatus
    func register(with name: String, surname: String, mail: String, password: String) async -> AuthManagerImpl.AuthStatus
    func updateAccessToken(refreshToken: String) async -> AuthManagerImpl.RefreshTokenStatus
}
