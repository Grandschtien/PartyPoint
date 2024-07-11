//
//  EndPointType.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 16.09.2022.
//

import Foundation

public protocol EndPointType {
    var enviromentslBaseUrl: String { get }
    var baseUrl: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
