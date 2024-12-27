import ProjectDescription

extension Target {
    public static func featureInterface(
        from target: Target,
        dependencies: [ProjectDescription.TargetDependency] = []
    ) -> Target {
        Target.target(
            name: "\(target.name)Interface",
            destinations: .iOS,
            product: target.product,
            bundleId: "\(target.bundleId).Interface",
            sources: ["Interfaces/**"]
        )
    }
}
