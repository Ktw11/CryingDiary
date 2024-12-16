import ProjectDescription

extension Targets {
    public static let network = Targets.commonTarget(
        name: TargetNames.network,
        parentName: Projects.core.name,
        sources: ["\(TargetNames.network)/Sources/**"]
    )

    public static let networkTests = TestTargets.make(
        from: Targets.network,
        sources: ["\(TargetNames.network)/Tests/**"]
    )
}
