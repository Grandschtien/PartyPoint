//
//  DesignSystem.swift
//  PartyPointManifests
//
//  Created by Егор Шкарин on 05.07.2024.
//

import ProjectDescription

fileprivate let targetName = "PartyPointDesignSystem"
fileprivate let basePath = "Targets/\(targetName)"

let designSystem = Target.target(
    name: targetName,
    destinations: .app,
    product: .staticFramework,
    bundleId: "\(Constants.organizationIdentifier).\(targetName)",
    sources: [
        "\(basePath)/Sources/**",
    ],
    dependencies: [
        .assets,
        .core,
        .xcframework(path: .relativeToRoot("Carthage/Build/Kingfisher.xcframework")),
        .xcframework(path: .relativeToRoot("Carthage/Build/SnapKit.xcframework")),
    ]
)

let designSystemTests = Target.target(
    name: "\(targetName)Tests",
    destinations: .tests,
    product: .unitTests,
    bundleId: "\(Constants.organizationIdentifier).\(targetName)",
    sources: [
        "\(basePath)/Tests/**",
    ], dependencies: [
        .xctest, .target(designSystem)
    ]
)

public extension TargetDependency {
    static let designSystem = TargetDependency.target(name: targetName)
    static let designSystemTests = TargetDependency.target(name: "\(targetName)Tests")
}
