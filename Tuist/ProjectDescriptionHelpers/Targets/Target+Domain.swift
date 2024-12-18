import ProjectDescription

extension Targets {
    public static let domain = Targets.commonTarget(
        name: TargetNames.domain,
        parentName: Projects.core.name,
        sources: ["\(TargetNames.domain)/Sources/**"]
    )

    public static let domainTests = TestTargets.make(
        from: Targets.domain,
        sources: ["\(TargetNames.domain)/Tests/**"]
    )
}
