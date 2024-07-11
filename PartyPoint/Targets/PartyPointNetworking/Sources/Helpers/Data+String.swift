//
//  Data+String.swift
//  PartyPointCore
//
//  Created by Егор Шкарин on 09.07.2024.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
