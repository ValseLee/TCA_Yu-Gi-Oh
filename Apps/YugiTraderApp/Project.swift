import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.mainApp(
    name: "YugiTraderApp",
    targetDependencies: [
        .commonModule,
        .yugiTraderAppInternal,
        .yugiTraderChat,
        .yugiTraderLogin
    ]
)
