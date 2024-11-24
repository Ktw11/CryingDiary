import ProjectDescription

extension Targets {
    public static let cryingDiary = Target.target(
        name: Names.cryingDiary,
        destinations: .iOS,
        product: .app,
        bundleId: "com.gtw.cryingDiary",
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
        sources: ["\(Names.cryingDiary)/Sources/**"],
        resources: ["\(Names.cryingDiary)/Resources/**"],
        dependencies: [
            .external(name: "KakaoSDK")
        ],
        settings: .settings(
            configurations: [
                .debug(name: ConfigurationName.debugName, xcconfig: Configurations.debugPath),
                .release(name: ConfigurationName.releaseName, xcconfig: Configurations.releasePath),
            ]
        )
    )
    
    public static let cryingDiaryTests = TestTargets.make(from: Self.cryingDiary)
}
