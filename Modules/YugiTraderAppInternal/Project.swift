import ProjectDescription
import ProjectDescriptionHelpers

private let name = "YugiTraderAppInternal"
private let googlePlist: InfoPlist = .file(path: .relativeToManifest("Support/GoogleService-Info.plist"))

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
            // Internal > Support > Info.plist
            infoPlist: googlePlist,
            sources: [],
            resources: [],
            dependencies: [
                .firebaseMessaging
            ]
        )
    ]
)
