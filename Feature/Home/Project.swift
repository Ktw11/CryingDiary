import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: FeatureProjects.home.name,
    settings: .settings(
        base: Settings.baseSettings
    ),
    targets: [
        .target(
            name: FeatureProjects.home.name,
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "gtw.CryingDiary.Feature.Home",
            sources: ["Sources/**"],
            dependencies: [
                .project(target: TargetNames.useCase, path: .relativeToRoot("Core"))
            ]
        )
    ]
)
