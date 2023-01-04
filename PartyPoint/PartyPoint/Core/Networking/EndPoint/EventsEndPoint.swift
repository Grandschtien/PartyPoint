//
//  EventsEndPoint.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 04.10.2022.
//

import Foundation

enum EventsEndPoint {
    case mainEvents(page: Int)
    case closeEvents(page: Int, lat: Double, lon: Double)
    case todayEvents(page: Int)
    case event
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
        case .event:
            return "event"
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
        case let .mainEvents(page):
            return .requestParameters(bodyParameters: nil, urlParameters: ["page": page])
        case let .closeEvents(page, lat, lon):
            return .requestParameters(bodyParameters: nil, urlParameters: ["page": page,
                                                                           "lat": lat,
                                                                           "lon": lon])
        case let .todayEvents(page):
            return .requestParameters(bodyParameters: nil, urlParameters: ["page": page])
        case .event:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
