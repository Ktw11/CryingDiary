import ProjectDescription
import ProjectDescriptionHelpers

let name = Projects.core.name

let project = Project(
    name: name,
    settings: .settings(
        base: Settings.baseSettings
    ),
    targets: [
        Targets.useCase,
        Targets.useCaseTests,
        Targets.repository,
        Targets.repositoryTests,
        Targets.network,
        Targets.networkTests
    ]
)
