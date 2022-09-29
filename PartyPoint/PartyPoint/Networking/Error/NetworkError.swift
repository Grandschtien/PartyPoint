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
}
