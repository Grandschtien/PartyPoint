//
//  App.swift
//  PartyPointManifests
//
//  Created by Егор Шкарин on 05.07.2024.
//

import ProjectDescription

fileprivate let targetName = "PartyPoint"
fileprivate let basePath = "Targets/\(targetName)"

fileprivate let dependecies = [.assets, .databases, .designSystem, .core, .navigation, .networking] + Constants.projectDependencies

let app = Target.target(
    name: targetName,
    destinations: .iOS,
    product: .app,
    bundleId: "\(Constants.organizationIdentifier).\(targetName)",
    infoPlist: .extendingSharedDefault(with: [
        "NSCameraUsageDescription" : .string("We need camera, to take your photo or choose one for your profile picture"),
        "NSLocationWhenInUseUsageDescription": .string("We use location to find nearest event for you"),
        "UIAppFonts": .array([
            .string("SFProDisplay-Black.ttf"),
            .string("SFProDisplay-Bold.ttf"),
            .string("SFProDisplay-Semibold.ttf"),
            .string("SFProDisplay-Regular.ttf")
        ]),
        "CFBundleIdentifier": .string("${PRODUCT_BUNDLE_IDENTIFIER}"),
        "CFBundleExecutable": .string("${EXECUTABLE_NAME}"),
        "CFBundleDisplayName": .string("${PRODUCT_NAME}"),
        "UISupportedInterfaceOrientations": .array([.string("UIInterfaceOrientationPortrait")]),
        "LSMinimumSystemVersion": .string("{IPHONEOS_DEPLOYMENT_TARGET}"),
        "CFBundlePackageType": .string("APPL"),
        "UILaunchStoryboardName": .string("LaunchScreen"),
        "UIApplicationSceneManifest": .dictionary([
            "UIApplicationSupportsMultipleScenes": .boolean(true),
            "UISceneConfigurations": .dictionary([
                "UIWindowSceneSessionRoleApplication": .array([
                    .dictionary([
                        "UISceneConfigurationName": .string("Default Configuration"),
                        "UISceneDelegateClassName": .string("$(PRODUCT_MODULE_NAME).SceneDelegate")
                    ])
                ])
            ])
        ])
    ]),
    sources: [
        "\(basePath)/Sources/**",
    ],
    dependencies: dependecies,
    settings: .settings(configurations: Configuration.current)
)

let appTests = Target.target(
    name: "\(targetName)Tests",
    destinations: .tests,
    product: .unitTests,
    bundleId: "\(Constants.organizationIdentifier).\(targetName)",
    sources: [
        "\(basePath)/Tests/**",
    ], dependencies: [
        .xctest, .target(app)
    ]
)
