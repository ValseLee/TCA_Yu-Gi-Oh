import Foundation

private let name = "Utilities"

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
            resources: [],
            dependencies: [
                .sendbirdChatSDK,
                .composableArchitecture
            ]
        )
    ]
)
