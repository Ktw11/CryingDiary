import ProjectDescription
import ProjectDescriptionHelpers

let target: Target = .target(
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

let project = Projects.makeFeatureProj(
    name: FeatureProjects.signIn.name,
    targets: [
        target,
        Target.featureInterface(
            from: target,
            dependencies: [.project(target: TargetNames.domain, path: .relativeToRoot("Core"))]
        )
    ]
)
