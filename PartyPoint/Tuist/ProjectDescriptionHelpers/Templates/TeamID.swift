//
//  TeamID.swift
//  PartyPointManifests
//
//  Created by Егор Шкарин on 05.07.2024.
//

import Foundation

public struct TeamID: RawRepresentable, CustomStringConvertible, ExpressibleByStringInterpolation {
    public var rawValue: String
    public var description: String { rawValue }
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
}
