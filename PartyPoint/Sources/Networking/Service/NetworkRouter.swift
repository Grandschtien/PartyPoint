//
//  NetworkRouter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 29.09.2022.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter {
    associatedtype EndPoint: EndPointType
    func request(
        _ route: EndPoint
    ) async -> (data: Data?, response: URLResponse?, error: Error?)
    func cancel(index: Int)
    func cancelAll()
}
