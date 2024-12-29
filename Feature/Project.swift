import ProjectDescription
import ProjectDescriptionHelpers

let name = Projects.feature.name

#warning("Add Helper methods at dependencies")
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
            dependencies: [
                FeatureProjects.home.project,
                TargetDependency.project(target: "HomeInterface", path: "../Feature/Home"),
                FeatureProjects.signIn.project,
                TargetDependency.project(target: "SignInInterface", path: "../Feature/SignIn"),
                FeatureProjects.newPost.project,
                TargetDependency.project(target: "NewPostInterface", path: "../Feature/NewPost"),
            ]
        )
    ]
)
