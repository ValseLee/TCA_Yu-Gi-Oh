import ProjectDescription
import ProjectDescriptionHelpers

private let name = "CommonUI"

let project = Project(
    name: name,
    organizationName: "Celan",
    targets: [
        Target(
            name: name,
            platform: .iOS,
            // SDK Type, No Resources -> Static Framework
            product: .staticFramework,
            bundleId: "com.Celan.\(name)",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
            infoPlist: .default,
            sources: [.glob(.relativeToManifest("Sources/**"))],
            resources: [],
            dependencies: []
        )
    ]
)
