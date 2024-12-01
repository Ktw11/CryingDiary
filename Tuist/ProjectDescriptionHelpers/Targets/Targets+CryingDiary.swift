import ProjectDescription

extension Targets {
    public static let cryingDiary = Target.target(
        name: Names.cryingDiary,
        destinations: .iOS,
        product: .app,
        bundleId: "gtw.CryingDiary",
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
        entitlements: .file(path: .path("\(Names.cryingDiary)/CryingDiary.entitlements")),
        dependencies: [
            .target(name: Names.network),
            .target(name: Names.thirdPartyAuth)
        ],
        settings: Settings.commonModule
    )
    
    public static let cryingDiaryTests = TestTargets.make(from: Self.cryingDiary)
}
