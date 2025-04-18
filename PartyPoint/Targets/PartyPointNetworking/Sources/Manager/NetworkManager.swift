//
//  NetworkManager.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 29.09.2022.
//

import Foundation
import PartyPointResources

open class NetworkManager {
    public enum NetworkResponse {
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
                return PartyPointResourcesStrings.Localizable.youNeedToBeAuthenticatedFirst
            case .wrongPassword:
                return PartyPointResourcesStrings.Localizable.wrongPasswordOrEmail
            case .badRequest:
                return PartyPointResourcesStrings.Localizable.badRequest
            case .serverError:
                return PartyPointResourcesStrings.Localizable.serverError
            case .outdated:
                return PartyPointResourcesStrings.Localizable.theUrlYouRequestedIdOutdated
            case .failed:
                return PartyPointResourcesStrings.Localizable.networkRequestFailed
            case .noData:
                return PartyPointResourcesStrings.Localizable.responseReturnedWithNoDataToDecode
            case .unableToDecode:
                return PartyPointResourcesStrings.Localizable.weCouldNotToDecodeTheResponse
            case .thisEmailAlreadyExists:
                return PartyPointResourcesStrings.Localizable.emailIsAlreadyExists
            case .notFound:
                return PartyPointResourcesStrings.Localizable.notFound
            }
            return nil
        }
    }
    
    public enum ResponseResult {
        case success
        case failure(String?)
    }
    
    public enum DefaultResultOfRequest {
        case success(Data?)
        case failure(String?)
    }
    
    public static let enviroment: NetworkEnviroment = .production
    
    public init() {}
    
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
    
    public func getStatus(response: URLResponse?) -> ResponseResult {
        guard let response = response else {
            return .failure(PartyPointResourcesStrings.Localizable.networkRequestFailed)
        }
        let httpResponse = response as? HTTPURLResponse
        let status = handleNetworkResponse(httpResponse)
        return status
    }
}
