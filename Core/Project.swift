import ProjectDescription
import ProjectDescriptionHelpers

let name = Names.core

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
