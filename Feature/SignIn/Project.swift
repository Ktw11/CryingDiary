import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: FeatureProjects.signIn.name,
    options: .options(
        defaultKnownRegions: ["ko", "en"],
        developmentRegion: "ko"
    ),
    settings: Settings.commonModule,
    targets: [
        .target(
            name: FeatureProjects.signIn.name,
            destinations: .iOS,
            product: Environment.forPreview.getBoolean(default: false) ? .framework : .staticFramework,
            bundleId: "gtw.CryingDiary.Feature.SignIn",
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: TargetNames.domain, path: .relativeToRoot("Core")),
                Projects.thirdParty.project
            ]
        )
    ]
)
