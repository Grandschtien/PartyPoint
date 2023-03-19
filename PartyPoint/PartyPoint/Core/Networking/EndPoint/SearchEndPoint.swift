//
//  SearchEndPoint.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 18.03.2023.
//

import Foundation

enum SearchEndPoint {
    case search(lexeme: String, page: Int, token: String)
}

extension SearchEndPoint: EndPointType {
    
    var enviromentslBaseUrl: String {
        switch NetworkManager.enviroment {
        case .qa:
            return "https://diplomatest.site/api/events/external/search"
        case .production:
            return "https://diplomatest.site/api/events/external/search"
        case .debug:
            return "https://diplomatest.site/api/events/external/search"
        }
    }
    
    var baseUrl: URL {
        guard let url = URL(string: enviromentslBaseUrl) else {
            fatalError("Base url is Invalid")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .search:
            return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case let .search(lexeme, page, token):
            return .requestParametersWithHeaders(bodyParameters: nil,
                                                 urlParameters: ["q": lexeme, "page": "\(page)"],
                                                 additionalParameters: ["Authorization": "Bearer \(token)"])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
