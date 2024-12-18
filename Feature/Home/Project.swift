import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: FeatureProjects.home.name,
    settings: Settings.commonModule,
    targets: [
        .target(
            name: FeatureProjects.home.name,
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "gtw.CryingDiary.Feature.Home",
            sources: ["Sources/**"],
            dependencies: [
                .project(target: TargetNames.domain, path: .relativeToRoot("Core"))
            ]
        )
    ]
)
