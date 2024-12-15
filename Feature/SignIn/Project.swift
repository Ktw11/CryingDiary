import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: FeatureProjects.signIn.name,
    settings: .settings(
        base: Settings.baseSettings
    ),
    targets: [
        .target(
            name: FeatureProjects.signIn.name,
            destinations: .iOS,
            product: Environment.forPreview.getBoolean(default: false) ? .framework : .staticFramework,
            bundleId: "gtw.CryingDiary.Feature.SignIn",
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: TargetNames.useCase, path: .relativeToRoot("Core"))
            ]
        )
    ]
)
