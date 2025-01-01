import ProjectDescription

public extension Target {
    static func feature(
        name: String,
        dependencies: [TargetDependency]
    ) -> Target {
        Target.target(
            name: name,
            destinations: .iOS,
            product: Environment.forPreview.getBoolean(default: false) ? .framework : .staticFramework,
            bundleId: "gtw.\(Names.cryingDiary).\(Names.feature).\(name)",
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: dependencies
        )
    }
    
    static func featureInterface(
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

public extension Project {
    static func makeFeatureProj(name: String, targets: [Target]) -> Project {
        Project(
            name: name,
            options: .options(
                defaultKnownRegions: ["ko", "en"],
                developmentRegion: "ko"
            ),
            settings: Settings.commonModule,
            targets: targets
        )
    }
}
