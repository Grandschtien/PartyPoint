//
//  ValidationTokenManager.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.11.2022.
//

import Foundation

protocol ValidationTokenManager {
    func saveTokens(_ tokens: PPToken) throws
    func getAccessToken() async throws -> String
    func getValidTokens() async throws -> (access: String, refresh: String)
    func getCurrentTokens() throws -> (access: String, refresh: String)
    func removeTokens()
    var isValidRefresh: Bool { get }
}
