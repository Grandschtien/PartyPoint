//
//  Core.swift
//  PartyPointManifests
//
//  Created by Егор Шкарин on 05.07.2024.
//

import ProjectDescription

fileprivate let targetName = "PartyPointCore"
fileprivate let basePath = "Targets/\(targetName)"

let core = Target.target(
    name: targetName,
    destinations: .app,
    product: .staticFramework,
    bundleId: "\(Constants.organizationIdentifier).\(targetName)",
    sources: [
        "\(basePath)/Sources/**",
    ],
    dependencies: [
        .xcframework(path: .relativeToRoot("Carthage/Build/SwiftSoup.xcframework"))
    ]
)

let coreTests = Target.target(
    name: "\(targetName)Tests",
    destinations: .tests,
    product: .unitTests,
    bundleId: "\(Constants.organizationIdentifier).\(targetName)",
    sources: [
        "\(basePath)/Tests/**",
    ], dependencies: [
        .xctest, .target(core)
    ]
)

public extension TargetDependency {
    static let core = TargetDependency.target(name: targetName)
    static let coreTests = TargetDependency.target(name: "\(targetName)Tests")
}
