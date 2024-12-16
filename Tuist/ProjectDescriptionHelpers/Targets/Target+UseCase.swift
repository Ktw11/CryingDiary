import ProjectDescription

extension Targets {
    public static let useCase = Targets.commonTarget(
        name: TargetNames.useCase,
        parentName: Projects.core.name,
        sources: ["\(TargetNames.useCase)/Sources/**"],
        dependencies: [
            .target(name: Targets.repository.name)
        ]
    )

    public static let useCaseTests = TestTargets.make(
        from: Targets.useCase,
        sources: ["\(TargetNames.useCase)/Tests/**"]
    )
}
