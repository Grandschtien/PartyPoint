//
//  Constants.swift
//  PartyPointManifests
//
//  Created by Егор Шкарин on 05.07.2024.
//

import ProjectDescription

public enum Constants {
    public static let organizationName = "Egor Shkarin"

    public static let organizationIdentifier = "com.egorshkarin"
    
    public static let appName = "PartyPoint"
    
    public static let version: Version = "0.1.0"
    
    public static let projectTargets = [
        app,
        assets,
        core, coreTests,
        designSystem, designSystemTests,
        databases, databasesTests,
        navigation, navigationTests,
        networking, networkingTests
    ]
    
    public static let projectDependencies: [TargetDependency] = [
        .xcframework(path: .relativeToRoot("Carthage/Build/Kingfisher.xcframework")),
        .xcframework(path: .relativeToRoot("Carthage/Build/SnapKit.xcframework")),
        .xcframework(path: .relativeToRoot("Carthage/Build/Lottie.xcframework")),
        .xcframework(path: .relativeToRoot("Carthage/Build/SwiftSoup.xcframework"))
    ]
}
