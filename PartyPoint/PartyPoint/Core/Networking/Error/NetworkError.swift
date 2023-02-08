//
//  NetworkError.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 16.09.2022.
//

import Foundation


public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil"
    case encodingFailed = "Parameter encoding failed"
    case missingUrl = "URL is nil"
    case noInternetConnection = "Please, check internet connection"
    case emptyData = "Data for upload is empty"
}

public enum NetworkResponses: Error {
    case clientError(response: Int)
    case serverError(response: Int)
    case other
}

extension NetworkResponses {
    var getString: String {
        switch self {
        case .clientError(response: let response):
            return "Client error, status code \(response)"
        case .serverError(response: let response):
            return "Server error, status code \(response)"
        case .other:
            return "Unknown error and ststus code"
        }
    }
}
