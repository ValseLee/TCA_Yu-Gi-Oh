import ProjectDescription
import ProjectDescriptionHelpers

let dependencies = Dependencies(
    swiftPackageManager: SwiftPackageManagerDependencies([
        .sendbirdSDK,
        .composableArchitecture,
        .firebase
    ])
)
