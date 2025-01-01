import ProjectDescription

extension Targets {
    public static let cryingDiary = Target.target(
        name: Names.cryingDiary,
        destinations: .iOS,
        product: .app,
        bundleId: "gtw.\(Names.cryingDiary)",
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
            .project(target: Names.feature, path: .relativeToRoot(Names.feature)),
            .project(target: Names.repository, path: .relativeToRoot(Names.core)),
            .project(target: Names.thirdParty, path: .relativeToRoot(Names.thirdParty)),
            .project(target: Names.sharedResource, path: .relativeToRoot(Names.sharedResource)),
        ],
        settings: Settings.commonModule
    )
    
    public static let cryingDiaryTests = TestTargets.make(from: Self.cryingDiary)
}
