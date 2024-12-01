import ProjectDescription

extension Targets {
    public static let network = Target.target(
        name: Names.network,
        destinations: .iOS,
        product: .staticFramework,
        bundleId: "gtw.Network",
        sources: ["\(Names.network)/Sources/**"],
        settings: Settings.commonModule
    )
    
    public static let networkTests = TestTargets.make(from: Self.network)
}
