//
//  SearchManangerFactory.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 18.03.2023.
//

import Foundation
import PartyPointNetworking

final class SearchManangerFactory {
    static func assembly() -> SearchManager {
        let router = Router<SearchEndPoint>()
        let tokenManager = TokenManagerFactory.assembly()
        let searchManager = SearchManagerImpl(router: router, tokenMananger: tokenManager)
        return searchManager
    }
}
