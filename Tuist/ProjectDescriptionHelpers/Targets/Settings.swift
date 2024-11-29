import ProjectDescription

public enum Settings {
    public static let baseSettings: SettingsDictionary = [
        "IPHONEOS_DEPLOYMENT_TARGET": "18.0",
        "SWIFT_VERSION": "6.0",
        "SWIFT_STRICT_CONCURRENCY": "complete",
        "CODE_SIGN_IDENTITY": "Apple Development",
        "DEVELOPMENT_TEAM": "$(DEV_TEAM_ID)",
        "PROVISIONING_PROFILE_SPECIFIER": "",
        "CODE_SIGN_STYLE": "Automatic",
        "ENABLE_TESTABILITY": "YES"
    ]
    
    public static let commonModule: ProjectDescription.Settings = .settings(
        base: Settings.baseSettings,
        configurations: [
            .debug(name: ConfigurationName.debugName, xcconfig: Configurations.debugPath),
            .release(name: ConfigurationName.releaseName, xcconfig: Configurations.releasePath),
        ]
    )
}
