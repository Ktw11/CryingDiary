import ProjectDescription
import ProjectDescriptionHelpers

let name: String = Names.Feature.newPost.rawValue

let target = Target.feature(
    name: name,
    dependencies: [
        .project(target: Names.domain, path: .relativeToRoot(Names.core)),
        .project(target: Names.sharedResource, path: .relativeToRoot(Names.sharedResource)),
    ]
)

let project = Project.makeFeatureProj(
    name: name,
    targets: [
        target,
        Target.featureInterface(from: target)
    ]
)
