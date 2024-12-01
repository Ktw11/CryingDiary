import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "CryingDiary",
    settings: .settings(
        base: Settings.baseSettings,
        configurations: [
            .debug(name: ConfigurationName.debugName),
            .release(name: ConfigurationName.releaseName),
        ]
    ),
    targets: [
        Targets.cryingDiary,
        Targets.cryingDiaryTests,
        Targets.network,
        Targets.networkTests,
        Targets.thirdPartyAuth,
        Targets.thirdPartyAuthTests,
    ],
    schemes: [
        .scheme(
            name: "\(Names.cryingDiary)-\(ConfigurationNames.debug)",
            buildAction: .buildAction(targets: [.target(Names.cryingDiary)]),
            runAction: .runAction(configuration: ConfigurationName.debugName),
            archiveAction: .archiveAction(configuration: ConfigurationName.debugName),
            profileAction: .profileAction(configuration: ConfigurationName.debugName),
            analyzeAction: .analyzeAction(configuration: ConfigurationName.debugName)
        ),
        .scheme(
            name: "\(Names.cryingDiary)-\(ConfigurationNames.release)",
            buildAction: .buildAction(targets: [.target(Names.cryingDiary)]),
            runAction: .runAction(configuration: ConfigurationName.releaseName),
            archiveAction: .archiveAction(configuration: ConfigurationName.releaseName),
            profileAction: .profileAction(configuration: ConfigurationName.releaseName),
            analyzeAction: .analyzeAction(configuration: ConfigurationName.releaseName)
        ),
    ]
)
