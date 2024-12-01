import ProjectDescription

extension Targets {
    public static let thirdPartyAuth = Target.target(
        name: Names.thirdPartyAuth,
        destinations: .iOS,
        product: .staticFramework,
        bundleId: "gtw.ThirdPartyAuth",
        sources: ["\(Names.thirdPartyAuth)/Sources/**"],
        dependencies: [
            .external(name: "KakaoSDK")
        ],
        settings: Settings.commonModule
    )
    
    public static let thirdPartyAuthTests = TestTargets.make(from: Self.thirdPartyAuth)
}
