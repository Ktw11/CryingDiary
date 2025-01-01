import ProjectDescription

extension Targets {
    public static let network = Targets.commonTarget(
        name: Names.network,
        parentName: Names.core,
        sources: ["\(Names.network)/Sources/**"]
    )

    public static let networkTests = TestTargets.make(
        from: Targets.network,
        sources: ["\(Names.network)/Tests/**"]
    )
}
