//
//  self.swift
//  PartyPointManifests
//
//  Created by Егор Шкарин on 07.07.2024.
//

import ProjectDescription

public struct LocalFramework {
    let name: String
    let path: String
    
    func makeFrameworkTargets(platform: Destinations) -> [Target] {
        let relativePath = "../\(self.path)/Targets/\(self.name)"
        
        let sourceTarget = Target.target(
            name: self.name,
            destinations: platform,
            product: .framework,
            bundleId: "\(Constants.organizationIdentifier).\(self.name)",
            infoPlist: .default,
            sources: ["\(relativePath)/Sources/**"],
            resources: [],
            headers: Headers.headers(public: ["\(relativePath)/Sources/**/*.h"]),
            dependencies: []
        )
        
        let testTarget = Target.target(
            name: self.name,
            destinations: platform,
            product: .framework,
            bundleId: "\(Constants.organizationIdentifier).\(self.name)Tests",
            infoPlist: .default,
            sources: ["\(relativePath)/Tests/**"],
            resources: [],
            dependencies: [ .target(name: self.name), .xctest ]
        )
        
        return [sourceTarget, testTarget]
    }
}
