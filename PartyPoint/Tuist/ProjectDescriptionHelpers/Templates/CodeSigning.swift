//
//  CodeSigning.swift
//  PartyPointManifests
//
//  Created by Егор Шкарин on 05.07.2024.
//

import Foundation

import ProjectDescription

public enum CodeSigning {
    public struct Identity: ExpressibleByStringInterpolation, RawRepresentable {
        public var rawValue: String
        
        public static let appleDevelopment: Self = "Apple Development"

        public static let appleDistribution: Self = "Apple Distribution"
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        public init(stringLiteral value: String) {
            self.init(rawValue: value)
        }
    }
    
    public var settings: SettingsDictionary {
        switch self {
        case .automatic(let teamID):
            return [
                "CODE_SIGN_STYLE": "Automatic",
                "DEVELOPMENT_TEAM": .string(teamID.rawValue),
                "PROVISIONING_PROFILE_SPECIFIER": "",
            ]
        case let .manual(team, identity, provisioningSpecifier):
            return [
                "CODE_SIGN_STYLE": "Manual",
                "CODE_SIGN_IDENTITY": .string(identity.rawValue),
                "DEVELOPMENT_TEAM": .string(team.rawValue),
                "PROVISIONING_PROFILE_SPECIFIER": .string(provisioningSpecifier),
            ]
        }
    }
    
    case automatic(TeamID)
    
    case manual(team: TeamID, identity: Identity, provisioningSpecifier: String)
}
