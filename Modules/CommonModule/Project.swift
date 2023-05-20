import ProjectDescription

enum Constants {
    static let ORG_NAME = "Celan"
    static let APP_NAME = "YugiTrader"
}

let project = Project(
    name: "CommonModule",
    organizationName: Constants.ORG_NAME,
    targets: [
        Target(
            name: "CommonModule",
            platform: .iOS,
            product: .framework,
            bundleId: "com.\(Constants.ORG_NAME).\(Constants.APP_NAME).CommonModule",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .external(name: "SendbirdChatSDK"),
                .external(name: "Kingfisher"),
                .external(name: "swift-composable-architecture")
            ]
        )
    ]
)

