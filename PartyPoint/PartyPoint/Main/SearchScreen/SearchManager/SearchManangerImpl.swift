//
//  SearchManangerImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 18.03.2023.
//

import Foundation

final class SearchManagerImpl: NetworkManager, SearchManager {
    private let router: Router<SearchEndPoint>
    private let tokenMananger: ValidationTokenManager
    
    init(router: Router<SearchEndPoint>, tokenMananger: ValidationTokenManager) {
        self.router = router
        self.tokenMananger = tokenMananger
    }
    
    func search(lexeme: String, page: Int) async -> DefaultResultOfRequest {
        let token = try? await tokenMananger.getAccessToken()
        guard let token = token else { return .failure(R.string.localizable.no_token()) }
        
        let result = await router.request(.search(lexeme: lexeme, page: page, token: token))
        
        switch getStatus(response: result.response) {
        case .success:
            return .success(result.data)
        case let .failure(reason):
            return .failure(reason)
        }
    }
}
