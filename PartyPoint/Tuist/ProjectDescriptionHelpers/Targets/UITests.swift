//
//  UITests.swift
//  ProjectDescriptionHelpers
//
//  Created by Егор Шкарин on 15.07.2024.
//

import ProjectDescription

fileprivate let targetName = "PartyPointUITests"
fileprivate let basePath = "Targets/\(targetName)"

let uitests = Target.target(
    name: targetName,
    destinations: .app,
    product: .uiTests,
    bundleId: "\(Constants.organizationIdentifier).\(targetName)",
    sources: [
        "\(basePath)/Sources/**",
    ],
    dependencies: [
        .target(app), .xctest
    ]
)

public extension TargetDependency {
    static let uitests = TargetDependency.target(name: targetName)
}

