//
//  MoreContentLoader.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 25.02.2023.
//

import Foundation

protocol MoreContentLoader {
    func loadContent(page: Int) async throws -> [PPEvent]
}
