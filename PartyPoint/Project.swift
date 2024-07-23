//
//  Config.swift
//  PartyPointManifests
//
//  Created by Егор Шкарин on 05.07.2024.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: Constants.appName,
    options: .options(
        automaticSchemesOptions: .disabled
    ),
    settings: .settings(configurations: Configuration.current),
    targets: Constants.projectTargets,
    schemes: [
        Scheme.scheme(
            name: Constants.appName,
            shared: true,
            buildAction: .buildAction(targets: [.target(Constants.appName)]),
            runAction: .runAction(configuration: .alpha),
            archiveAction: .archiveAction(configuration: .store)
        ),
        Scheme.scheme(
            name: .uitests,
            buildAction: .buildAction(targets: [.target(.uitests)]),
            testAction: .targets([.testableTarget(target: .target(.uitests))], configuration: .alpha),
            runAction: .runAction(configuration: .alpha)
        )
    ]
)
