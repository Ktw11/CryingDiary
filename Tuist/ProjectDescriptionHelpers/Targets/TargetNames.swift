import ProjectDescription

public enum TargetNames {
    public static let cryingDiary = "CryingDiary"
    public static let useCase = "UseCase"
    public static let repository = "Repository"
}

public enum ConfigurationNames {
    public static let debug: String = "DEBUG"
    public static let release = "RELEASE"
}

public extension ConfigurationName {
    static let debugName: ConfigurationName = .init(stringLiteral: ConfigurationNames.debug)
    static let releaseName: ConfigurationName = .init(stringLiteral: ConfigurationNames.release)
}
