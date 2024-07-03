//
//  SearchManangerFactory.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 18.03.2023.
//

import Foundation

final class SearchManangerFactory {
    static func assembly() -> SearchManager {
        let router = Router<SearchEndPoint>()
        let tokenManager = TokenManagerFabric.assembly()
        let searchManager = SearchManagerImpl(router: router, tokenMananger: tokenManager)
        return searchManager
    }
}
