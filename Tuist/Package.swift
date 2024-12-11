// swift-tools-version: 5.9
@preconcurrency import PackageDescription

#if TUIST
    import ProjectDescription
    import ProjectDescriptionHelpers

    let packageSettings = PackageSettings(
        productTypes: ["KakaoSDK": .staticFramework]
//        baseSettings: .settings(
//            configurations: [
//                .debug(name: ConfigurationName.debugName),
//                .release(name: ConfigurationName.releaseName),
//            ]
//        )
    )
#endif

let package = Package(
    name: "CryingDiaryPackage",
    dependencies: [
        .package(url: "https://github.com/kakao/kakao-ios-sdk", exact: "2.23.0"),
    ]
)
