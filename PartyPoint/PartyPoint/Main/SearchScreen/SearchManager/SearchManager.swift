//
//  SearchManager.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 18.03.2023.
//

import Foundation

protocol SearchManager {
    func search(lexeme: String, page: Int) async -> NetworkManager.DefaultResultOfRequest
}
