import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.mainApp(
    name: "YugiTraderApp",
    targetDependencies: [
        .yugiTraderAuth,
        .yugiTraderChat
    ]
)
