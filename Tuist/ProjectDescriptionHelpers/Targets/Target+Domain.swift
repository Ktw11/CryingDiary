import ProjectDescription

extension Targets {
    public static let domain = Targets.commonTarget(
        name: Names.domain,
        parentName: Names.core,
        sources: ["\(Names.domain)/Sources/**"]
    )

    public static let domainTests = TestTargets.make(
        from: Targets.domain,
        sources: ["\(Names.domain)/Tests/**"]
    )
}
