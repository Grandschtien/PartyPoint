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
        disableBundleAccessors: true,
        disableSynthesizedResourceAccessors: true
    ),
    settings: .settings(configurations: Configuration.current),
    targets: Constants.projectTargets
)
