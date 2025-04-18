//
//  SearchManager.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 18.03.2023.
//

import Foundation
import PartyPointNetworking

protocol SearchManager {
    func search(lexeme: String, page: Int) async -> NetworkManager.DefaultResultOfRequest
}
