//
//  EventsEndPoint.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 04.10.2022.
//

import Foundation

enum EventsEndPoint {
    case mainEvents(page: Int, token: String)
    case closeEvents(page: Int, lat: Double, lon: Double, token: String)
    case todayEvents(page: Int, token: String)
    case event(id: Int, placeId: Int, token: String)
}

extension EventsEndPoint: EndPointType {
    
    var enviromentslBaseUrl: String {
        switch NetworkManager.enviroment {
        case .qa:
            return "https://diplomatest.site/api/events"
        case .production:
            return "https://diplomatest.site/api/events"
        case .debug:
            return "https://diplomatest.site/api/events"
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
        case .mainEvents:
            return "/external"
        case .closeEvents:
            return "external/close"
        case .todayEvents:
            return "external/today"
        case let .event(id, placeId, _):
            return "/external/\(placeId)/\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .mainEvents:
            return .get
        case .closeEvents:
            return .get
        case .todayEvents:
            return .get
        case .event:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case let .mainEvents(page, token):
            return .requestParametersWithHeaders(bodyParameters: nil,
                                                 urlParameters: ["page": page],
                                                 additionalParameters: ["Authorization": "Bearer \(token)"])
        case let .closeEvents(page, lat, lon, token):
            return .requestParametersWithHeaders(bodyParameters: nil,
                                                 urlParameters: ["page": page,
                                                                 "lat": lat,
                                                                 "lon": lon],
                                                 additionalParameters: ["Authorization": "Bearer \(token)"])
        case let .todayEvents(page, token):
            return .requestParametersWithHeaders(bodyParameters: nil,
                                                 urlParameters: ["page": page],
                                                 additionalParameters: ["Authorization": "Bearer \(token)"])
        case let .event(_, _, token):
            return .requestParametersWithHeaders(bodyParameters: nil,
                                                 urlParameters: nil,
                                                 additionalParameters: ["Authorization": "Bearer \(token)"])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
