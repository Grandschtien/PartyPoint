//
//  Reouter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 29.09.2022.
//

import Foundation

final class Router<EndPoint: EndPointType>: NetworkRouter {
    private var tasks: [Task<Data?, Error>] = []
    
    func request(_ route: EndPoint) async throws -> Data? {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            let task = Task { () -> Data? in
                let (data, response) = try await session.data(for: request)
                guard let error = checkResponse(response: response) else {
                    return data
                }
                throw error
            }
            tasks.append(task)
            return try await task.value
        } catch {
            return nil
        }
    }
    
    func cancelAll() {
        self.tasks.forEach { $0.cancel() }
    }
    
    func cancel(index: Int) {
        self.tasks[index].cancel()
    }
}

private extension Router {
    func checkResponse(response: URLResponse) -> NetworkResponses? {
        guard let response = response as? HTTPURLResponse else {
            return NetworkResponses.other
        }
        
        switch response.statusCode {
        case 200..<300:
            return nil
        case 300..<400:
            return NetworkResponses.serverError(response: response.statusCode)
        case 400..<500:
            return NetworkResponses.clientError(response: response.statusCode)
        default:
            return NetworkResponses.other
        }
    }
    
    func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseUrl.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case let .requestParameters(bodyParameters,
                                        urlParameters):
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)
            case let .requestParametersWithHeaders(bodyParameters,
                                                   urlParameters,
                                                   additionalParameters):
                self.addAdditionalHeaders(additionalParameters,
                                          request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch  {
            throw error
        }
    }
    
    func configureParameters(bodyParameters: Parameters?,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let additionalHeaders = additionalHeaders else {
            return
        }
        for (key, value) in additionalHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
