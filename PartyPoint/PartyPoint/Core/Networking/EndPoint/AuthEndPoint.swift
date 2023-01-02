//
//  AuthEndPoint.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 04.10.2022.
//

import Foundation


enum AuthEndPoint {
    case login(email: String, passwd: String)
    case logout
    case refresh(refreshToken: String)
    case signUp(email: String, name: String, passwd: String, surname: String)
}


extension AuthEndPoint: EndPointType {
    var enviromentslBaseUrl: String {
        switch NetworkManager.enviroment {
        case .qa:
            return "https://diplomatest.site/api/auth"
        case .production:
            return "https://45.141.102.243:8080/api/auth"
        case .debug:
            return "https://diplomatest.site/api/auth"
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
        case .login:
            return "/login"
        case .logout:
            return "/logout"
        case .refresh:
            return "/refresh"
        case .signUp:
            return "/signup"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .logout:
            return .get
        case .refresh:
            return .post
        case .signUp:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case let .login(email, passwd):
            return .requestParameters(bodyParameters: ["email": email,
                                                       "password": passwd],
                                      urlParameters: nil)
        case .logout:
            return .request
        case let .refresh(refreshTocken):
            return .requestParameters(bodyParameters: ["refresh_token": refreshTocken],
                                      urlParameters: nil)
        case let .signUp(email, name, passwd, surname):
            return .requestParameters(bodyParameters: ["email": email,
                                                       "name": name,
                                                       "password": passwd,
                                                       "surname": surname],
                                      urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
