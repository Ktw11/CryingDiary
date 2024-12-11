import ProjectDescription

extension Targets {
    public static let cryingDiary = Target.target(
        name: TargetNames.cryingDiary,
        destinations: .iOS,
        product: .app,
        bundleId: "gtw.\(TargetNames.cryingDiary)",
        infoPlist: .extendingDefault(
            with: [
                "UILaunchScreen": [
                    "UIColorName": "",
                    "UIImageName": "",
                ],
                "KakaoAppKey": "$(KAKAO_APP_KEY)",
                "BaseURL": "$(API_BASE_URL)",
                "LSApplicationQueriesSchemes": [
                    "kakaokompassauth"
                ]
            ]
        ),
        sources: ["Sources/**"],
        resources: ["Resources/**"],
        entitlements: .file(path: .relativeToManifest("CryingDiary.entitlements")),
        dependencies: [
//            .project(target: Projects.feature.name, path: .relativeToRoot("Feature")),
            Projects.feature.project,
            .project(target: TargetNames.useCase, path: .relativeToRoot("Core")),
            .project(target: TargetNames.repository, path: .relativeToRoot("Core")),
            .project(target: Projects.thirdParty.name, path: .relativeToRoot("ThirdParty"))
//            Projects.feature.project,
//            Projects.core.project,
//            Projects.thirdParty.project
        ],
        settings: Settings.commonModule
    )
    
    public static let cryingDiaryTests = TestTargets.make(from: Self.cryingDiary)
}
