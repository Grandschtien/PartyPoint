//
//  MultipartDataEncoder.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 01.02.2023.
//

import Foundation

public struct MultipartDataEncoder: MultiPartParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters, andMedia media: Media) throws {
        var multipartRequest = MultipartRequest()
        multipartRequest.add(parameters: parameters)
        multipartRequest.add(key: media.key, fileName: media.fileName, fileMimeType: media.mimeType, fileData: media.data)
        urlRequest.httpBody = multipartRequest.httpBody
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue(multipartRequest.httpContentTypeHeadeValue, forHTTPHeaderField: "Content-Type")
        }
    }
}
