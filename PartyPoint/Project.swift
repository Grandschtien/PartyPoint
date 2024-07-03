import ProjectDescription

let project = Project(
    name: "PartyPoint",
    targets: [
        .target(
            name: "PartyPoint",
            destinations: .iOS,
            product: .app,
            bundleId: "com.egorshkarin.PartyPoint",
            infoPlist: .file(path: "./PartyPoint/Info.plist"),
            sources: ["PartyPoint/**"],
            resources: ["PartyPoint/**"],
            dependencies: []
        )
    ]
)
