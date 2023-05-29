import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.subApp(
    name: "YugiTraderChat",
    targetDependencies: [
        .commonModule,
        .yugiTraderAppInternal,
        .yugiTraderChatUI,
        .yugiTraderChatKit
    ]
)
