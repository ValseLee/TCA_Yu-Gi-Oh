import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.subApp(
    name: "YugiTraderLogin",
    targetDependencies: [
        .commonModule,
        .yugiTraderAppInternal,
        .yugiTraderLoginUI,
        .yugiTraderLoginKit
    ]
)
