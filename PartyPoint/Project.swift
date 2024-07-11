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
        automaticSchemesOptions: .enabled(
            targetSchemesGrouping: .byNameSuffix(
                build: ["_Testing", "_Interface"],
                test: ["_Tests"],
                run: []
            ),
            codeCoverageEnabled: true,
            testLanguage: "ru",
            testRegion: "RU"
        ),
        developmentRegion: "ru",
        textSettings: .textSettings(
            usesTabs: false,
            indentWidth: 4,
            tabWidth: 4,
            wrapsLines: true
        )
    ),
    settings: .settings(
        base: [
            "DEBUG_INFORMATION_FORMAT": "dwarf-with-dsym",
            "EAGER_LINKING": true,
            "ENABLE_MODULE_VERIFIER": true,
            "ENABLE_USER_SCRIPT_SANDBOXING": true,
            "IPHONEOS_DEPLOYMENT_TARGET": "15.0",
            "MARKETING_VERSION": .string(Constants.version.description),
            "OTHER_LDFLAGS": "-ObjC",
        ],
        configurations: [.current]
    ),
    targets: Constants.projectTargets
)
