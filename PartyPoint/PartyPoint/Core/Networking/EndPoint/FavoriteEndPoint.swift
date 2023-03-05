//
//  FavoriteEndPoint.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 05.03.2023.
//

import Foundation

enum FavoriteEndPoint {
    case getFavourites(userId: Int, token: String)
}

extension FavoriteEndPoint: EndPointType {
    
    var enviromentslBaseUrl: String {
        switch NetworkManager.enviroment {
        case .qa:
            return "https://diplomatest.site/api/events/external"
        case .production:
            return "https://diplomatest.site/api/events/external"
        case .debug:
            return "https://diplomatest.site/api/events/external"
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
        case let .getFavourites(userId, _):
            return "likes/\(userId)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getFavourites:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case let .getFavourites(_, token):
            return .requestParametersWithHeaders(bodyParameters: nil,
                                                 urlParameters: nil,
                                                 additionalParameters: ["Authorization": "Bearer \(token)"])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
