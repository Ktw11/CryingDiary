import ProjectDescription
import ProjectDescriptionHelpers

let name = Projects.sharedResource.name

let project = Project(
    name: name,
    targets: [
        Targets.commonTarget(
            name: name,
            sources: nil,
            resources: ["Resources/**"]
        )
    ]
)
