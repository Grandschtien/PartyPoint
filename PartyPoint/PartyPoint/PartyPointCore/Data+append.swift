//
//  Data+append.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 01.02.2023.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
