//
//  EventsEndPoint.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 04.10.2022.
//

import Foundation

enum EventsEndPoint {
    case event(id: String)
    case events(page: Int)
    case events(placeId: Int)
}

extension EventsEndPoint: EndPointType {
    
    var enviromentslBaseUrl: String {
        switch NetworkManager.enviroment {
        case .qa:
            return "http://45.141.102.243:8080/api"
        case .production:
            return "http://45.141.102.243:8080/api"
        case .debug:
            return "http://127.0.0.1:8080/api/"
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
        case let .event(id):
            return "/events/\(id)"
        case let .events(page):
            return "No hand"
        case let .events(placeId):
            return "/places/\(placeId)/events"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        default: return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
