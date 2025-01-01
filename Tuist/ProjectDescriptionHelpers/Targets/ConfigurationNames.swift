import ProjectDescription

public enum ConfigurationNames {
    public static let debug: String = "DEBUG"
    public static let release = "RELEASE"
}

public extension ConfigurationName {
    static let debugName: ConfigurationName = .init(stringLiteral: ConfigurationNames.debug)
    static let releaseName: ConfigurationName = .init(stringLiteral: ConfigurationNames.release)
}
