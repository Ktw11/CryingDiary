import ProjectDescription
import ProjectDescriptionHelpers

let name: String = Names.feature

let featureNames: [String] = Names.Feature.allCases.map(\.rawValue)

let dependencies: [TargetDependency] = featureNames.reduce(into: []) { result, name in
    result.append(.project(target: name, path: "../Feature/\(name)"))
    result.append(.project(target: "\(name)Interface", path: "../Feature/\(name)"))
}

let project = Project(
    name: name,
    settings: Settings.commonModule,
    targets: [
        .target(
            name: name,
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "gtw.CryingDiary.\(name)",
            sources: ["Sources/**"],
            dependencies: dependencies
        )
    ]
)
