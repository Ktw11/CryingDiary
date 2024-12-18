import ProjectDescription

extension Targets {
    public static let repository = Targets.commonTarget(
        name: TargetNames.repository,
        parentName: Projects.core.name,
        sources: ["\(TargetNames.repository)/Sources/**"],
        dependencies: [
            .target(name: Targets.network.name),
            .target(name: Targets.domain.name)
        ]
    )
    
    public static let repositoryTests = TestTargets.make(
        from: Self.repository,
        sources: ["\(TargetNames.repository)/Tests/**"]
    )
}
