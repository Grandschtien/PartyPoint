import ProjectDescription

let project = Project(
    name: "PartyPoint",
    options: .options(disableBundleAccessors: true, disableSynthesizedResourceAccessors: true),
    targets: [
        .target(
            name: "PartyPoint",
            destinations: .iOS,
            product: .app,
            bundleId: "com.egorshkarin.PartyPoint",
            infoPlist: createInfoPlist(forTarget: .debug),
            sources: ["Sources/**"],
            resources: [
                "Sources/Resources/Generated/**",
                "Sources/Resources/Assets.xcassets/**",
                "Sources/Resources/Storyboards/**",
                "Sources/Resources/Fonts/**",
                "Sources/Resources/Localization/**"
            ],
            dependencies: [
                .xcframework(path: .relativeToRoot("Carthage/Build/Kingfisher.xcframework")),
                .xcframework(path: .relativeToRoot("Carthage/Build/SnapKit.xcframework")),
                .xcframework(path: .relativeToRoot("Carthage/Build/Lottie.xcframework")),
                .xcframework(path: .relativeToRoot("Carthage/Build/SwiftSoup.xcframework"))
            ]
        )
    ]
)

public enum PartyPointTarget {
    case debug
    case adHoc
    case release
}

func createInfoPlist(forTarget target: PartyPointTarget) -> InfoPlist {
    return .extendingDefault(with: [
        "NSCameraUsageDescription" : .string("We need camera, to take your photo"),
        "NSLocationWhenInUseUsageDescription": .string("We use location to find events near you"),
        "UIAppFonts": .array([
            .string("SFProDisplay-Black.ttf"),
            .string("SFProDisplay-Bold.ttf"),
            .string("SFProDisplay-Semibold.ttf"),
            .string("SFProDisplay-Regular.ttf")
        ]),
        "CFBundleVersion": .string("1.0"),
        "CFBundleShortVersionString": .string("1.0"),
        "CFBundleIdentifier": .string("${PRODUCT_BUNDLE_IDENTIFIER}"),
        "CFBundleExecutable": .string("${EXECUTABLE_NAME}"),
        "CFBundleDisplayName": .string("${PRODUCT_NAME}"),
        "UISupportedInterfaceOrientations": .array([.string("UIInterfaceOrientationPortrait")]),
        "LSMinimumSystemVersion": .string("16.0"),
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
    ])
}
