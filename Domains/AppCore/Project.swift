import ProjectDescription
import ProjectDescriptionHelpers

private let name = "AppCore"

private let infoPlist: [String: InfoPlist.Value] = [
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
]

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
            infoPlist: .extendingDefault(with: infoPlist),
            sources: [.glob(.relativeToManifest("Sources/**"))],
            resources: [],
            dependencies: [
                .firebaseMessaging,
            ],
            settings: .settings(
                configurations: [
                    .release(
                        name: .release,
                        settings: .firebase
                    ),
                    .debug(
                        name: .debug,
                        settings: .firebase
                    )
                ],
                defaultSettings: .recommended
            ),
            additionalFiles: [
                // Internal > Support > GoogleService-Info.plist
                .glob(pattern: .relativeToManifest("Support/GoogleService-Info.plist"))
            ]
        )
    ]
)
