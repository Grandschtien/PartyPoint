//
//  Navigation.swift
//  PartyPointManifests
//
//  Created by Егор Шкарин on 05.07.2024.
//

import ProjectDescription

fileprivate let targetName = "PartyPointNavigation"
fileprivate let basePath = "Targets/\(targetName)"

let navigation = Target.target(
    name: targetName,
    destinations: .app,
    product: .staticFramework,
    bundleId: "\(Constants.organizationIdentifier).\(targetName)",
    sources: [
        "\(basePath)/Sources/**",
    ]
)

let navigationTests = Target.target(
    name: "\(targetName)Tests",
    destinations: .tests,
    product: .unitTests,
    bundleId: "\(Constants.organizationIdentifier).\(targetName)",
    sources: [
        "\(basePath)/Tests/**",
    ], dependencies: [
        .xctest, .target(navigation)
    ]
)

public extension TargetDependency {
    static let navigation = TargetDependency.target(name: targetName)
    static let navigationTests = TargetDependency.target(name: "\(targetName)Tests")
}
