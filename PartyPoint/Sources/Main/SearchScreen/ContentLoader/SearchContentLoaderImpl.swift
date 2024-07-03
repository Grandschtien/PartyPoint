//
//  SearchContentLoaderImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 18.03.2023.
//

import Foundation

final class SearchContentLoaderImpl {
    private let searchManager: SearchManager
    private let decoder: PPDecoder
    
    private var currentLexeme = ""
    private var foundEvents: [EventInfo] = []
    
    init(searchManager: SearchManager, decoder: PPDecoder) {
        self.searchManager = searchManager
        self.decoder = decoder
    }
    
    private func createInfoModels(data: Data?) -> [EventInfo] {
        guard let data = data,
              let events = decoder.parseJSON(from: data, type: PPEvents.self)
        else { return [] }
        return EventsConverter.getEventsInfo(events: events.events)
    }
}

extension SearchContentLoaderImpl: SearchContentLoader {
    func loadInitialContentContent(lexeme: String) async -> [EventInfo] {
        let status = await searchManager.search(lexeme: lexeme, page: 1)
        currentLexeme = lexeme
        
        switch status {
        case let .success(data):
            let infoModels = createInfoModels(data: data)
            foundEvents = infoModels
            return infoModels
        case let .failure(reason):
            print(reason ?? "")
            return []
        }
    }
    
    func loadMoreContentByLexeme(page: Int) async -> [EventInfo] {
        let status = await searchManager.search(lexeme: currentLexeme, page: page)
        
        switch status {
        case let .success(data):
            let infoModels = createInfoModels(data: data)
            foundEvents.append(contentsOf: infoModels)
            return infoModels
        case let .failure(reason):
            return []
        }
    }
    
    func clearSearch() {
        currentLexeme = ""
        foundEvents = []
    }
    
    func getEvent(byIndex index: Int) -> EventInfo {
        return foundEvents[index]
    }
}
