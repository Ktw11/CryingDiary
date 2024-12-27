import ProjectDescription
import ProjectDescriptionHelpers

let target: Target = .target(
    name: FeatureProjects.home.name,
    destinations: .iOS,
    product: Environment.forPreview.getBoolean(default: false) ? .framework : .staticFramework,
    bundleId: "gtw.CryingDiary.Feature.Home",
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    dependencies: [
        .project(target: TargetNames.domain, path: .relativeToRoot("Core")),
        .project(target: TargetNames.sharedResource, path: .relativeToRoot(TargetNames.sharedResource)),
    ]
)

let project = Projects.makeFeatureProj(
    name: FeatureProjects.home.name,
    targets: [
        target,
        Target.featureInterface(from: target)
    ]
)
