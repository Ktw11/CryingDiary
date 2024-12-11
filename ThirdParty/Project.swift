import ProjectDescription
import ProjectDescriptionHelpers

let name = Projects.thirdParty.name

let project = Project(
    name: name,
    settings: .settings(
        base: Settings.baseSettings
    ),
    targets: [
        Targets.commonTarget(
            name: name,
            sources: ["Sources/**"],
            dependencies: [
                .external(name: "KakaoSDK")
            ]
        )
    ]
)
