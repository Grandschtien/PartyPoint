//
//  Databeses.swift
//  PartyPointManifests
//
//  Created by Егор Шкарин on 05.07.2024.
//

import ProjectDescription

fileprivate let targetName = "PartyPointDB"
fileprivate let basePath = "Targets/\(targetName)"

let databases = Target.target(
    name: targetName,
    destinations: .app,
    product: .staticFramework,
    bundleId: "\(Constants.organizationIdentifier).\(targetName)",
    sources: [
        "\(basePath)/Sources/**",
    ]
)

let databasesTests = Target.target(
    name: "\(targetName)Tests",
    destinations: .tests,
    product: .unitTests,
    bundleId: "\(Constants.organizationIdentifier).\(targetName)",
    sources: [
        "\(basePath)/Tests/**",
    ], dependencies: [
        .xctest, .target(databases)
    ]
)

public extension TargetDependency {
    static let databases = TargetDependency.target(name: targetName)
    static let databasesTests = TargetDependency.target(name: "\(targetName)Tests")
}
