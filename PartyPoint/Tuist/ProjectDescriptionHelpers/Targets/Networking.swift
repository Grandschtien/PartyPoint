//
//  Networking.swift
//  PartyPointManifests
//
//  Created by Егор Шкарин on 05.07.2024.
//

import ProjectDescription

fileprivate let targetName = "PartyPointNetworking"
fileprivate let basePath = "Targets/\(targetName)"

let networking = Target.target(
    name: targetName,
    destinations: .app,
    product: .staticFramework,
    bundleId: "\(Constants.organizationIdentifier).\(targetName)",
    sources: [
        "\(basePath)/Sources/**",
    ],
    dependencies: [
        .assets
    ]
)

let networkingTests = Target.target(
    name: "\(targetName)Tests",
    destinations: .tests,
    product: .unitTests,
    bundleId: "\(Constants.organizationIdentifier).\(targetName)",
    sources: [
        "\(basePath)/Tests/**",
    ], dependencies: [
        .xctest, .target(networking)
    ]
)

public extension TargetDependency {
    static let networking = TargetDependency.target(name: targetName)
    static let networkingTests = TargetDependency.target(name: "\(targetName)Tests")
}

