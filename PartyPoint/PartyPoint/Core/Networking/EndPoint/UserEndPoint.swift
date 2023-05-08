//
//  UserEndPoint.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 08.05.2023.
//

import Foundation

enum UserEndPoint {
    case changePassword(token: String, passwd: String)
    case updateImage(userId: String, image: Data)
}

extension UserEndPoint: EndPointType {
    var enviromentslBaseUrl: String {
        switch NetworkManager.enviroment {
        case .qa:
            return "https://diplomatest.site/api/users"
        case .production:
            return "https://diplomatest.site/api/users"
        case .debug:
            return "https://diplomatest.site/api/users"
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
        case .changePassword:
            return "/password"
        case let .updateImage(userId, _):
            return "/\(userId)/image"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .changePassword:
            return .post
        case .updateImage:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case let .changePassword(token, passwd):
            return .requestParametersWithHeaders(
                bodyParameters: ["password": passwd],
                urlParameters: nil,
                additionalParameters: ["Authorization": "Bearer \(token)"]
            )
        case .updateImage:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
