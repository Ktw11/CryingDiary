import ProjectDescription
import ProjectDescriptionHelpers

let name = Projects.core.name

let project = Project(
    name: name,
    settings: Settings.commonModule,
    targets: [
        Targets.domain,
        Targets.domainTests,
        Targets.repository,
        Targets.repositoryTests,
        Targets.network,
        Targets.networkTests
    ]
)
