import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: Projects.app.name,
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
            name: "\(Projects.app.name)-\(ConfigurationNames.debug)",
            buildAction: .buildAction(targets: [.target(TargetNames.cryingDiary)]),
            runAction: .runAction(configuration: ConfigurationName.debugName),
            archiveAction: .archiveAction(configuration: ConfigurationName.debugName),
            profileAction: .profileAction(configuration: ConfigurationName.debugName),
            analyzeAction: .analyzeAction(configuration: ConfigurationName.debugName)
        ),
        .scheme(
            name: "\(Projects.app.name)-\(ConfigurationNames.release)",
            buildAction: .buildAction(targets: [.target(TargetNames.cryingDiary)]),
            runAction: .runAction(configuration: ConfigurationName.releaseName),
            archiveAction: .archiveAction(configuration: ConfigurationName.releaseName),
            profileAction: .profileAction(configuration: ConfigurationName.releaseName),
            analyzeAction: .analyzeAction(configuration: ConfigurationName.releaseName)
        ),
    ]
)
