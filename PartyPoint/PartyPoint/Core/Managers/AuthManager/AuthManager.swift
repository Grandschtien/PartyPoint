//
//  AuthManager.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.11.2022.
//

import Foundation

protocol AuthManager {
    func login(with login: String, password: String) async -> AuthManagerImpl.AuthStatus
    func register(with info: PPRegisterUserInformation) async -> AuthManagerImpl.AuthStatus
    func updateAccessToken(refreshToken: String) async -> AuthManagerImpl.RefreshTokenStatus
    func sendCofirmCode(toEmail email: String) async -> AuthManagerImpl.AuthStatus
    func checkConfirmCode(email: String, code: Int) async -> AuthManagerImpl.AuthStatus
    func sendNewPassword(email: String, password: String) async -> AuthManagerImpl.AuthStatus
}
