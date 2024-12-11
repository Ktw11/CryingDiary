import ProjectDescription

extension Targets {
    public static let repository = Targets.commonTarget(
        name: TargetNames.repository,
        parentName: Projects.core.name,
        sources: ["\(TargetNames.repository)/Sources/**"]
    )
    
    public static let repositoryTests = TestTargets.make(
        from: Self.repository,
        sources: ["\(TargetNames.repository)/Tests/**"]
    )
}
