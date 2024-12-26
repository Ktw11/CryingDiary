import ProjectDescription
import ProjectDescriptionHelpers

let name = TargetNames.sharedResource

let fonts = [
    "BigJohnPRO-Bold.otf",
    "BigJohnPRO-Light.otf",
    "BigJohnPRO-Regular.otf",
]

let infoPlist: [String: Plist.Value] = [
    "Fonts provided by application": .array(fonts.map { .string($0) })
]

let project = Project(
    name: name,
    targets: [
        Target.target(
            name: name,
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "gtw.CryingDiary.\(name)",
            deploymentTargets: .iOS("18.0"),
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            settings: Settings.commonModule
        )
    ]
)
