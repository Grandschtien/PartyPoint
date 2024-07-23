//
//  Assets.swift
//  PartyPointManifests
//
//  Created by Егор Шкарин on 05.07.2024.
//

import ProjectDescription

fileprivate let targetName = "PartyPointResources"
fileprivate let basePath = "Targets/\(targetName)"

let assets = Target.target(
    name: targetName,
    destinations: .app,
    product: .framework,
    bundleId: "\(Constants.organizationIdentifier).\(targetName)",
    resources: [
        "\(basePath)/Assets.xcassets/**",
        "\(basePath)/Storyboards/**",
        "\(basePath)/Fonts/**",
        "\(basePath)/Localization/**"
    ]
)

public extension TargetDependency {
    static let assets = TargetDependency.target(name: targetName)
}
