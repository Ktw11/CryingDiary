import ProjectDescription

public enum Projects: String, CaseIterable {
    case app = "App"
    case feature = "Feature"
    case core = "Core"
    case thirdParty = "ThirdParty"
}

public extension Projects {
    var name: String {
        rawValue
    }
    
    var path: ProjectDescription.Path {
        return .relativeToRoot(self.name)
    }
    
    var project: TargetDependency {
        return TargetDependency.project(target: name, path: .relativeToRoot(name))
    }
    
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

public enum FeatureProjects: String {
    case home = "Home"
    case signIn = "SignIn"
}

public extension FeatureProjects {
    var name: String {
        rawValue
    }
    
    var path: ProjectDescription.Path {
        return .relativeToRoot("Feature/\(name)")
    }
    
    var project: TargetDependency {
        return TargetDependency.project(target: name, path: "../Feature/\(name)")
    }
}
