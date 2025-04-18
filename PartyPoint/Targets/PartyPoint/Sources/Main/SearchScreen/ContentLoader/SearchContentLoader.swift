//
//  SearchContentLoader.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 18.03.2023.
//

import Foundation

protocol SearchContentLoader {
    func loadInitialContentContent(lexeme: String) async -> [EventInfo]
    func loadMoreContentByLexeme(page: Int) async -> [EventInfo]
    func clearSearch()
    
    func getEvent(byIndex index: Int) -> EventInfo
}
