//
//  AuthManager.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.11.2022.
//

import Foundation

protocol AuthManager {
    func login(with login: String, password: String) async -> NetworkManager.DefaultResultOfRequest
    func register(with info: PPRegisterUserInformation) async -> NetworkManager.DefaultResultOfRequest
    func updateAccessToken(refreshToken: String) async -> NetworkManager.DefaultResultOfRequest
    func sendCofirmCode(toEmail email: String) async -> NetworkManager.DefaultResultOfRequest
    func checkConfirmCode(email: String, code: Int) async -> NetworkManager.DefaultResultOfRequest
    func sendNewPassword(email: String, password: String) async -> NetworkManager.DefaultResultOfRequest
    func logout(accessToken: String, refreshToken: String) async ->NetworkManager.DefaultResultOfRequest
}
