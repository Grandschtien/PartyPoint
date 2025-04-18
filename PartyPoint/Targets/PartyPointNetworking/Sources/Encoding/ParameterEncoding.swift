//
//  ParameterEncoding.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 16.09.2022.
//

import Foundation

public typealias Parameters = [String: Any]


public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public protocol MultiPartParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters, andMedia media: Media) throws
}
