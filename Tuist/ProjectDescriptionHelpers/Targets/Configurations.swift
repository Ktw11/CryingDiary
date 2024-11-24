import ProjectDescription

public enum Configurations {
    public static var debugPath: ProjectDescription.Path { .relativeToRoot("Configurations/debug.xcconfig") }
    public static var releasePath: ProjectDescription.Path { .relativeToRoot("Configurations/release.xcconfig") }
}
