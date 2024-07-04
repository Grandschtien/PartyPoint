//
//  NetworkManager.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 29.09.2022.
//

import Foundation

class NetworkManager {
    enum NetworkResponse {
        case success
        case authError
        case wrongPassword
        case thisEmailAlreadyExists
        case badRequest
        case serverError
        case notFound
        case outdated
        case failed
        case noData
        case unableToDecode
        
        var reasonString: String? {
            switch self {
            case .success:
                break
            case .authError:
                return PartyPointStrings.Localizable.youNeedToBeAuthenticatedFirst
            case .wrongPassword:
                return PartyPointStrings.Localizable.wrongPasswordOrEmail
            case .badRequest:
                return PartyPointStrings.Localizable.badRequest
            case .serverError:
                return PartyPointStrings.Localizable.serverError
            case .outdated:
                return PartyPointStrings.Localizable.theUrlYouRequestedIdOutdated
            case .failed:
                return PartyPointStrings.Localizable.networkRequestFailed
            case .noData:
                return PartyPointStrings.Localizable.responseReturnedWithNoDataToDecode
            case .unableToDecode:
                return PartyPointStrings.Localizable.weCouldNotToDecodeTheResponse
            case .thisEmailAlreadyExists:
                return PartyPointStrings.Localizable.emailIsAlreadyExists
            case .notFound:
                return PartyPointStrings.Localizable.notFound
            }
            return nil
        }
    }
    
    enum ResponseResult {
        case success
        case failure(String?)
    }
    
    enum DefaultResultOfRequest {
        case success(Data?)
        case failure(String?)
    }
    
    static let enviroment: NetworkEnviroment = .qa
    
    internal func handleNetworkResponse(_ response: HTTPURLResponse?) -> ResponseResult {
        guard let response = response else { return .failure(NetworkResponse.noData.reasonString) }
        switch response.statusCode {
        case 200...299 :
            return .success
        case 401:
            return .failure(NetworkResponse.authError.reasonString)
        case 403:
            return .failure(NetworkResponse.wrongPassword.reasonString)
        case 422:
            return .failure(NetworkResponse.badRequest.reasonString)
        case 404:
            return .failure(NetworkResponse.notFound.reasonString)
        case 409:
            return .failure(NetworkResponse.thisEmailAlreadyExists.reasonString)
        case 500...599:
            return .failure(NetworkResponse.serverError.reasonString)
        case 600:
            return .failure(NetworkResponse.outdated.reasonString)
        default:
            return .failure(NetworkResponse.failed.reasonString)
        }
    }
    
    internal func getStatus(response: URLResponse?) -> ResponseResult {
        guard let response = response else {
            return .failure(PartyPointStrings.Localizable.networkRequestFailed)
        }
        let httpResponse = response as? HTTPURLResponse
        let status = handleNetworkResponse(httpResponse)
        return status
    }
}
