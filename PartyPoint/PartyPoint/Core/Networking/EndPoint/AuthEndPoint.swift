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
    case signUp(name: String,
                surname: String,
                email: String,
                passwd: String,
                dateOfBirth: Date,
                city: String?,
                image: Data?)
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
        case let .signUp(name, surname, email, passwd, dateOfBirth, city, image):
            return .requestParametersWithHeaders(bodyParameters: ["name": name,
                                                                  "surname": surname,
                                                                  "email": email,
                                                                  "password": passwd,
                                                                  "dateOfBirth": dateOfBirth,
                                                                  "city": city ?? "",
                                                                  "image": image ?? Data()],
                                                 urlParameters: nil,
                                                 additionalParameters: ["Content-Type": "multipart/form-data"])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
