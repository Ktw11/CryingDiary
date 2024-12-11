import ProjectDescription
import ProjectDescriptionHelpers

let workspace = Workspace(
    name: "Projects",
    projects: [
        "App",
        "Core",
        "Feature/**",
        "ThirdParty",
    ]
)
