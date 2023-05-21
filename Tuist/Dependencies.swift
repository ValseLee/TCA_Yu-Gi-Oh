import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: .init([
        .remote(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            requirement: .branch("main")
        ),
        .remote(
            url: "https://github.com/sendbird/sendbird-chat-sdk-ios",
            requirement: .upToNextMinor(from: "4.6.3")
        )
    ])
)
