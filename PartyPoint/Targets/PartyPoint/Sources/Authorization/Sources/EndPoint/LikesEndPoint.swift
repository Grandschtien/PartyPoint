//
//  LikesEndPoint.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 28.02.2023.
//

import Foundation
import PartyPointNetworking

enum LikesEndPoint {
    case likeEvent(eventId: Int, token: String)
    case unlikeEvent(eventId: Int, token: String)
    case getFavourites(page: Int, userId: Int, token: String)
}

extension LikesEndPoint: EndPointType {
    
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
        case let .likeEvent(eventId, _):
            return "\(eventId)/like"
        case let .unlikeEvent(eventId, _):
            return "\(eventId)/dislike"
        case let .getFavourites(_, userId, _):
            return "likes/\(userId)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .likeEvent:
            return .post
        case .getFavourites:
            return .get
        case .unlikeEvent:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case let .likeEvent(_, token):
            return .requestParametersWithHeaders(bodyParameters: nil,
                                                 urlParameters: nil,
                                                 additionalParameters: ["Authorization": "Bearer \(token)"])
        case let .getFavourites(page, _, token):
            return .requestParametersWithHeaders(bodyParameters: nil,
                                                 urlParameters: ["page": "\(page)"],
                                                 additionalParameters: ["Authorization": "Bearer \(token)"])
        case let .unlikeEvent(_, token):
            return .requestParametersWithHeaders(bodyParameters: nil,
                                                 urlParameters: nil,
                                                 additionalParameters: ["Authorization": "Bearer \(token)"])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
