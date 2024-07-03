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
                return R.string.localizable.you_need_to_be_authenticated_first()
            case .wrongPassword:
                return R.string.localizable.wrong_password_or_email()
            case .badRequest:
                return R.string.localizable.bad_request()
            case .serverError:
                return R.string.localizable.server_error()
            case .outdated:
                return R.string.localizable.the_url_you_requested_id_outdated()
            case .failed:
                return R.string.localizable.network_request_failed()
            case .noData:
                return R.string.localizable.response_returned_with_no_data_to_decode()
            case .unableToDecode:
                return R.string.localizable.we_could_not_to_decode_the_response()
            case .thisEmailAlreadyExists:
                return R.string.localizable.email_is_already_exists()
            case .notFound:
                return R.string.localizable.not_found()
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
            return .failure(R.string.localizable.network_request_failed())
        }
        let httpResponse = response as? HTTPURLResponse
        let status = handleNetworkResponse(httpResponse)
        return status
    }
}
