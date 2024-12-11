import ProjectDescription
import ProjectDescriptionHelpers

let name = Projects.feature.name

let project = Project(
    name: name,
    settings: .settings(
        base: Settings.baseSettings
    ),
    targets: [
        .target(
            name: name,
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "gtw.CryingDiary.\(name)",
            sources: ["Sources/**"],
            dependencies: [
                FeatureProjects.home.project
            ]
        )
    ]
)
