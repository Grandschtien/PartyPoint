//
//  Reouter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 29.09.2022.
//

import Foundation

final class Router<EndPoint: EndPointType>: NetworkRouter {
    private var tasks: [Task<(Data?, URLResponse?, Error?), Error>] = []
    
    func request(_ route: EndPoint) async -> (data: Data?, response: URLResponse?, error: Error?) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            let task = Task { () -> (Data?, URLResponse?, Error?) in
                let (data, response) = try await session.data(for: request)
                return (data, response, nil)
            }
            
            tasks.append(task)
            return try await task.value
        } catch NetworkError.encodingFailed {
            return (nil, nil, NetworkError.encodingFailed)
        } catch {
            return (nil, nil, NetworkError.noInternetConnection)
        }
    }
    
    func uploadRequest(_ route: EndPoint) async -> (data: Data?, response: URLResponse?, error: Error?) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            let task = Task { () -> (Data?, URLResponse?, Error?) in
                if let data = request.httpBody {
                    let (data, response) = try await session.upload(for: request, from: data)
                    return (data, response, nil)
                } else {
                    return (nil, nil, NetworkError.emptyData)
                }
            }
            
            tasks.append(task)
            return try await task.value
        } catch NetworkError.encodingFailed {
            return (nil, nil, NetworkError.encodingFailed)
        } catch {
            return (nil, nil, NetworkError.noInternetConnection)
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
            case let .multiPartRequest(bodyParameters, urlParameters, media):
                try self.configureParamentersForMultiPartData(bodyParameters: bodyParameters,
                                                              urlParameters: urlParameters,
                                                              media: media,
                                                              request: &request)
                break
            }
            return request
        } catch  {
            throw NetworkError.encodingFailed
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
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    func configureParamentersForMultiPartData(bodyParameters: Parameters?,
                                              urlParameters: Parameters?,
                                              media: Media,
                                              request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try MultipartDataEncoder.encode(urlRequest: &request, with: bodyParameters, andMedia: media)
            }
            
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
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
