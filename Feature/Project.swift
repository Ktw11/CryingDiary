import ProjectDescription
import ProjectDescriptionHelpers

let name = Projects.feature.name

let project = Project(
    name: name,
    settings: Settings.commonModule,
    targets: [
        .target(
            name: name,
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "gtw.CryingDiary.\(name)",
            sources: ["Sources/**"],
            dependencies: [
                FeatureProjects.home.project,
                FeatureProjects.signIn.project
            ]
        )
    ]
)
