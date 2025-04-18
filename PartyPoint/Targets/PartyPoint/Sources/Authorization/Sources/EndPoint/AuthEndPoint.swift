//
//  AuthEndPoint.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 04.10.2022.
//

import Foundation
import PartyPointNetworking

enum AuthEndPoint {
    case login(email: String, passwd: String)
    case logout(accessToken: String, refreshToken: String)
    case refresh(refreshToken: String)
    case signUp(name: String,
                surname: String,
                email: String,
                passwd: String,
                dateOfBirth: String,
                image: Media)
    case sendCode(email: String)
    case checkConfirmationCode(code: Int, email: String)
    case credentials(email: String, passwd: String)
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
        case .sendCode:
            return "/redeem"
        case .checkConfirmationCode:
            return "/codecheck"
        case .credentials:
            return "/credentials"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .logout:
            return .post
        case .refresh:
            return .post
        case .signUp:
            return .post
        case .sendCode:
            return .post
        case .checkConfirmationCode:
            return .post
        case .credentials:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case let .login(email, passwd):
            return .requestParameters(bodyParameters: ["email": email,
                                                       "password": passwd],
                                      urlParameters: nil)
        case let .logout(accessToken, refreshToken):
            return .requestParametersWithHeaders(bodyParameters: ["refresh_token": refreshToken],
                                                 urlParameters: nil,
                                                 additionalParameters: ["Authorization": "Bearer \(accessToken)"])
        case let .refresh(refreshTocken):
            return .requestParameters(bodyParameters: ["refresh_token": refreshTocken],
                                      urlParameters: nil)
            
        case let .signUp(name, surname, email, passwd, dateOfBirth, image):
            return .multiPartRequest(bodyParameters: ["name": name,
                                                      "surname": surname,
                                                      "email": email,
                                                      "password": passwd,
                                                      "dateOfBirth": dateOfBirth],
                                     urlParameters: nil,
                                     media: image)
        case .sendCode(email: let email):
            return .requestParameters(bodyParameters: ["email": email],
                                      urlParameters: nil)
        case let .checkConfirmationCode(code, email):
            return .requestParameters(bodyParameters: ["email": email,
                                                       "redeem_code": code],
                                      urlParameters: nil)
        case let .credentials(email, passwd):
            return .requestParameters(bodyParameters: ["email": email,
                                                       "password": passwd], urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
