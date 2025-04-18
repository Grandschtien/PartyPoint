//
//  Configuration.swift
//  PartyPointManifests
//
//  Created by Егор Шкарин on 05.07.2024.
//

import ProjectDescription

public extension Configuration {
    static var current: [Self] {
        let rawValue = Environment.configuration.getString(default: "alpha").lowercased()

        let debugConfiguration: Self = .debug(
            name: ConfigurationName.alpha,
            xcconfig: .path("./PartyPoint-Debug.xcconfig")
        )
        
        let releaseConfiguration: Self = .release(
            name: ConfigurationName.store,
            xcconfig: .path("./PartyPoint-Store.xcconfig")
        )
                
        switch rawValue {
        case "alpha":
            return [debugConfiguration]
        case "store":
            return [releaseConfiguration, debugConfiguration]
        default:
            return [debugConfiguration]
        }
    }
        
    var isAlpha: Bool { name.rawValue.lowercased() == "alpha" }
    
    var isRelease: Bool { name.rawValue.lowercased() == "store" }
}

extension Configuration: CustomStringConvertible {
    public var description: String { name.rawValue }
}

extension ConfigurationName {
    public static var alpha: ConfigurationName {
        .configuration("Alpha")
    }
    
    public static var store: ConfigurationName {
        .configuration("Store")
    }
}
