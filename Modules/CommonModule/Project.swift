import ProjectDescription
import ProjectDescriptionHelpers

private let name = "CommonModule"

let project = Project(
    name: name,
    organizationName: "Celan",
    targets: [
        Target(
            name: name,
            platform: .iOS,
            product: .framework,
            bundleId: "com.Celan.\(name)",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
            infoPlist: .default,
            sources: [.glob(.relativeToManifest("Sources/**"))],
            resources: [.glob(pattern: .relativeToManifest("Resources/**"))],
            dependencies: [
                .sendbirdChatSDK,
                .composableArchitecture
            ]
        )
    ]
)
