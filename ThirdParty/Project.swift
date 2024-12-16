import ProjectDescription
import ProjectDescriptionHelpers

let name = Projects.thirdParty.name

let project = Project(
    name: name,
    settings: Settings.commonModule,
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
