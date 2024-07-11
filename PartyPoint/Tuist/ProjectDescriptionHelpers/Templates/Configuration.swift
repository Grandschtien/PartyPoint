//
//  Configuration.swift
//  PartyPointManifests
//
//  Created by Егор Шкарин on 05.07.2024.
//

import ProjectDescription

public extension Configuration {
    static var current: Self {
        let rawValue = Environment.configuration.getString(default: "debug").lowercased()
        let settings: SettingsDictionary = [
            "SWIFT_ACTIVE_COMPILATION_CONDITIONS": .string(rawValue.uppercased()),
        ]
        
        switch rawValue {
        case "debug": return .debug(name: "Debug", settings: settings)
        case "alpha": return .release(name: "alpha", settings: settings)
        case "release": return .release(name: "Release", settings: settings)
        default: return .debug(name: "Debug", settings: settings)
        }
    }
    
    var isDebug: Bool { name.rawValue.lowercased() == "debug" }
    
    var isAlpha: Bool { name.rawValue.lowercased() == "alpha" }
    
    var isRelease: Bool { name.rawValue.lowercased() == "release" }
}

extension Configuration: CustomStringConvertible {
    public var description: String { name.rawValue }
}
