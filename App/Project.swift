import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: Names.app,
    settings: .settings(
        base: Settings.baseSettings,
        configurations: [
            .debug(name: ConfigurationName.debugName, xcconfig: .relativeToRoot("CryingDiaryProject.xcconfig")),
            .release(name: ConfigurationName.releaseName, xcconfig: .relativeToRoot("CryingDiaryProject.xcconfig"))
        ]
    ),
    targets: [
        Targets.cryingDiary,
        Targets.cryingDiaryTests,
    ],
    schemes: [
        .scheme(
            name: "\(Names.app)-\(ConfigurationNames.debug)",
            buildAction: .buildAction(targets: [.target(Names.cryingDiary)]),
            runAction: .runAction(configuration: ConfigurationName.debugName),
            archiveAction: .archiveAction(configuration: ConfigurationName.debugName),
            profileAction: .profileAction(configuration: ConfigurationName.debugName),
            analyzeAction: .analyzeAction(configuration: ConfigurationName.debugName)
        ),
        .scheme(
            name: "\(Names.app)-\(ConfigurationNames.release)",
            buildAction: .buildAction(targets: [.target(Names.cryingDiary)]),
            runAction: .runAction(configuration: ConfigurationName.releaseName),
            archiveAction: .archiveAction(configuration: ConfigurationName.releaseName),
            profileAction: .profileAction(configuration: ConfigurationName.releaseName),
            analyzeAction: .analyzeAction(configuration: ConfigurationName.releaseName)
        ),
    ]
)
