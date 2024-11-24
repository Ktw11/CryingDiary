import ProjectDescription

extension Targets {
    public static let network = Target.target(
        name: Names.network,
        destinations: .iOS,
        product: .staticFramework,
        bundleId: "com.gtw.network",
        sources: ["Sources/**"]
    )
}
