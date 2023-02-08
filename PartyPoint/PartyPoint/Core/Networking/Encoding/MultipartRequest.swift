//
//  MultipartRequest.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 03.02.2023.
//

import Foundation

public struct MultipartRequest {
    
    enum DataType {
        case json
        case xml
    }
    
    public let boundary: String
    
    private let separator: String = "\r\n"
    private var data: Data

    public init(boundary: String = UUID().uuidString) {
        self.boundary = boundary
        self.data = .init()
    }
    
    private mutating func appendBoundarySeparator() {
        data.append("--\(boundary)\(separator)")
    }
    
    private mutating func appendTypeOfData(dataType: DataType) {
        data.append("Content-Type")
    }
    
    private mutating func appendSeparator() {
        data.append(separator)
    }

    private func disposition(_ key: String) -> String {
        "Content-Disposition: form-data; name=\"\(key)\""
    }

    public mutating func add(
        key: String,
        value: Any
    ) {
        guard let value = value as? String else {
            return
        }
        appendBoundarySeparator()
        data.append(disposition(key) + separator)
        appendSeparator()
        data.append(value + separator)
    }
    
    public mutating func add(
        parameters: Parameters
    ) {
        guard let json = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) else { return }
        appendBoundarySeparator()
        data.append(disposition("json") + separator)
        data.append("Content-Type: application/json" + separator + separator)
        data.append(json)
        appendSeparator()
    }

    public mutating func add(
        key: String,
        fileName: String,
        fileMimeType: String,
        fileData: Data
    ) {
        appendBoundarySeparator()
        data.append(disposition(key) + "; filename=\"\(fileName)\"" + separator)
        data.append("Content-Type: \(fileMimeType)" + separator + separator)
        data.append(fileData)
        appendSeparator()
    }

    public var httpContentTypeHeadeValue: String {
        "multipart/form-data; boundary=\(boundary)"
    }

    public var httpBody: Data {
        var bodyData = data
        bodyData.append("--\(boundary)--")
        return bodyData
    }
}
