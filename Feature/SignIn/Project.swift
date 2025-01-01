import ProjectDescription
import ProjectDescriptionHelpers

let name: String = Names.Feature.signIn.rawValue

let target = Target.feature(
    name: name,
    dependencies: [
        .project(target: Names.domain, path: .relativeToRoot(Names.core)),
        .project(target: Names.thirdParty, path: .relativeToRoot(Names.thirdParty))
    ]
)

let project = Project.makeFeatureProj(
    name: name,
    targets: [
        target,
        Target.featureInterface(
            from: target,
            dependencies: [.project(target: Names.domain, path: .relativeToRoot(Names.core))]
        )
    ]
)
