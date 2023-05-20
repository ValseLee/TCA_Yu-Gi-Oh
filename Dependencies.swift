import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: [
        .remote(
            url: "https://github.com/sendbird/sendbird-chat-sdk-ios",
            requirement: .upToNextMinor(from: "4.6.3")
        ),
        .remote(
            url: "https://github.com/onevcat/Kingfisher",
            requirement: .upToNextMinor(from: "7.2.0")
        ),
        .remote(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            requirement: .branch("main")
        )
    ],
    platforms: [.iOS]
)
