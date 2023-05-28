import ProjectDescription
import ProjectDescriptionHelpers

let dependencies = Dependencies(
    swiftPackageManager: .init([
        .sendbirdSDK,
        .composableArchitecture,
        .firebase
    ])
)
