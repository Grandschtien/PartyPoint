//
//  HTTPTask.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 16.09.2022.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?,
                           urlParameters: Parameters?)
    
    case requestParametersWithHeaders(bodyParameters: Parameters?,
                                      urlParameters: Parameters?,
                                      additionalParameters: HTTPHeaders?)
}
