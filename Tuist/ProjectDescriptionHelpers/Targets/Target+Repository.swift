import ProjectDescription

extension Targets {
    public static let repository = Targets.commonTarget(
        name: Names.repository,
        parentName: Names.core,
        sources: ["\(Names.repository)/Sources/**"],
        dependencies: [
            .target(name: Names.network),
            .target(name: Names.domain)
        ]
    )
    
    public static let repositoryTests = TestTargets.make(
        from: Self.repository,
        sources: ["\(Names.repository)/Tests/**"]
    )
}
