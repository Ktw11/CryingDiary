import ProjectDescription

public enum Targets { }

extension Targets {
    public static func commonTarget(
        name: String,
        parentName: String? = nil,
        sources: SourceFilesList?,
        resources: ResourceFileElements? = nil,
        dependencies: [TargetDependency] = []
    ) -> Target {
        let parentBundleId: String = {
            guard let parentName else { return "" }
            return ".\(parentName)"
        }()
        
        return Target.target(
            name: name,
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "gtw.CryingDiary\(parentBundleId).\(name)",
            sources: sources,
            resources: resources ?? []
        )
    }
}
