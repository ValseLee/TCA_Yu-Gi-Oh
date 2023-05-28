import ProjectDescription

// MARK: - TARGET DEPENDENCY > EXTERNAL
public extension TargetDependency {
    static let firebaseMessaging: Self = .external(name: "FirebaseMessaging")
    static let sendbirdChatSDK: Self = .external(name: "SendbirdChatSDK")
    static let composableArchitecture: Self = .external(name: "ComposableArchitecture")
}

// MARK: - TARGET DEPENDENCY > PROJECT
public extension TargetDependency {
    static let commonModule: Self = .project(
        target: "CommonModule",
        path: .relativeToRoot("Modules/CommonModule")
    )
    
    static let yugiTraderChat: Self = .project(
        target: "YugiTraderChat",
        path: .relativeToRoot("Apps/YugiTraderChat")
    )
    static let yugiTraderLogin: Self = .project(
        target: "YugiTraderLogin",
        path: .relativeToRoot("Apps/YugiTraderLogin")
    )
    static let yugiTraderAppInternal: Self = .project(
        target: "YugiTraderAppInternal",
        path: .relativeToRoot("Modules/YugiTraderAppInternal")
    )
}

/**
 SPM 에서 Resolve 할 Package Target을 설정합니다.
 모든 Package는 Dependencies 파일에서 관리하며, 프로젝트는 external로 접근하여 패키지 타겟을 빌드합니다.
 */
public extension Package {
    static let firebase: Package = .remote(
        url: "https://github.com/firebase/firebase-ios-sdk",
        requirement: .upToNextMajor(from: "9.0.0")
    )
    
    static let composableArchitecture: Package = .remote(
        url: "https://github.com/pointfreeco/swift-composable-architecture",
        requirement: .branch("main")
    )
    
    static let sendbirdSDK: Package = .remote(
        url: "https://github.com/sendbird/sendbird-chat-sdk-ios",
        requirement: .upToNextMinor(from: "4.6.3")
    )
}

public extension SettingsDictionary {
    static let firebase: Self = [
        "DEBUG_INFORMATION_FORMAT": "dwarf-with-dsym",
        "OTHER_LDFLAGS": "-ObjC"
    ]
}

extension Project {
    /**
     App의 @main, IntroPoint를 설정하는 메소드
     */
    public static func mainApp(name: String) -> Project {
        Project(
            name: name,
            organizationName: "Celan",
            targets: [
                makeAppTarget(
                    name: name,
                    platform: .iOS,
                    dependencies: [
                        .commonModule,
                        .yugiTraderAppInternal,
                        .yugiTraderChat,
                        .yugiTraderLogin
                    ]
                )
            ]
        )
    }
    
    /**
     해당하는 모든 프로젝트 타겟에 공통으로 CommonModule 의존성 주입
     */
    public static func app(name: String) -> Project {
        Project(
            name: name,
            organizationName: "Celan",
            targets: [
                makeAppTarget(
                    name: name,
                    platform: .iOS,
                    dependencies: [
                        .commonModule,
                        .yugiTraderAppInternal
                    ]
                )
            ]
        )
    }
    
    private static func makeAppTarget(
        name: String,
        platform: Platform,
        dependencies: [TargetDependency]
    ) -> Target {
        let platform: Platform = platform
        
        let infoPlist: [String: InfoPlist.Value] = [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UIMainStoryboardFile": "",
            "UILaunchStoryboardName": "LaunchScreen",
        ]

        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "com.Celan.\(name)",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
            infoPlist: .extendingDefault(with: infoPlist),
            sources: [.glob(.relativeToManifest("Sources/**"))],
            resources: [.glob(pattern: .relativeToManifest("Resources/**"))],
            dependencies: dependencies,
            settings: .settings(
                configurations: [
                    .debug(name: .debug, settings: .firebase),
                    .release(name: .release, settings: .firebase)
                ],
                defaultSettings: .recommended
            )
        )
        
        return mainTarget
    }
}
