import ProjectDescription

public enum TestTargets {
    public static func make(
        from target: Target,
        dependencies: [ProjectDescription.TargetDependency] = [],
        sources: SourceFilesList? = nil
    ) -> Target {
        var dependencies = dependencies
        
        dependencies.append(.target(name: target.name))
        // Swift Testing 사용 시 수정?
        dependencies.append(.xctest)
        
        return Target.target(
            name: "\(target.name)Tests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "\(target.bundleId).tests",
            sources: sources ?? [
                "Tests/**"
            ],
            dependencies: dependencies
        )
    }
}
