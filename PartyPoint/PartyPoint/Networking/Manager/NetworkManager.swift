//
//  NetworkManager.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 29.09.2022.
//

import Foundation

final class NetworkManager {
    
    enum NetworkResponse: String {
        case success
        case authError = "You need to be authenticated first"
        case badRequest = "Bad request"
        case outdated = "The url you requested id outdated"
        case failed = "Netwrok request failed"
        case noData = "Response returned with no data to decode"
        case unableToDecaode = "We could not to decode the response"
    }
    
    enum ResponseResult {
        case success
        case failure(String)
    }
    
    static let enviroment: NetworkEnviroment = .production
    static let apiKey = "key"
    //router
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> ResponseResult {
        switch response.statusCode {
        case 200...299 :
            return .success
        case 401...500:
            return .failure(NetworkResponse.authError.rawValue)
        case 500...599:
            return .failure(NetworkResponse.badRequest.rawValue)
        case 600:
            return .failure(NetworkResponse.outdated.rawValue)
        default:
            return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
