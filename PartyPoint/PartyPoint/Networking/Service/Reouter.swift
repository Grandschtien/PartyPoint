//
//  Reouter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 29.09.2022.
//

import Foundation

final class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseUrl.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            switch route.tast {
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
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
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
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let additionalHeaders = additionalHeaders else {
            return
        }
        for (key, value) in additionalHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
