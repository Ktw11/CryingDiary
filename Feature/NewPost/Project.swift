import ProjectDescription
import ProjectDescriptionHelpers

let target: Target = .target(
    name: FeatureProjects.newPost.name,
    destinations: .iOS,
    product: Environment.forPreview.getBoolean(default: false) ? .framework : .staticFramework,
    bundleId: "gtw.CryingDiary.Feature.NewPost",
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    dependencies: [
        .project(target: TargetNames.domain, path: .relativeToRoot("Core")),
        .project(target: TargetNames.sharedResource, path: .relativeToRoot(TargetNames.sharedResource)),
    ]
)

let project = Projects.makeFeatureProj(
    name: FeatureProjects.newPost.name,
    targets: [
        target,
        Target.featureInterface(from: target)
    ]
)
