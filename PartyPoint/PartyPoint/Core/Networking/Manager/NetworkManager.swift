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
        case outdated
        case failed
        case noData
        case unableToDecode
        
        var reasonString: String? {
            switch self {
            case .success:
                break
            case .authError:
                return Localizable.you_need_to_be_authenticated_first()
            case .wrongPassword:
                return Localizable.wrong_password_or_email()
            case .badRequest:
                return Localizable.bad_request()
            case .serverError:
                return Localizable.server_error()
            case .outdated:
                return Localizable.the_url_you_requested_id_outdated()
            case .failed:
                return Localizable.network_request_failed()
            case .noData:
                return Localizable.response_returned_with_no_data_to_decode()
            case .unableToDecode:
                return Localizable.we_could_not_to_decode_the_response()
            case .thisEmailAlreadyExists:
                return Localizable.email_is_already_exists()
            }
            return nil
        }
    }
    
    enum ResponseResult {
        case success
        case failure(String?)
    }
    
    static let enviroment: NetworkEnviroment = .debug
    
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
}
