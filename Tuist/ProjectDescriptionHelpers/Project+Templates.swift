import ProjectDescription

// MARK: - TARGET DEPENDENCY > EXTERNAL
public extension TargetDependency {
    static let firebaseMessaging: Self = .external(name: "FirebaseMessaging")
    static let sendbirdChatSDK: Self = .external(name: "SendbirdChatSDK")
    static let composableArchitecture: Self = .external(name: "ComposableArchitecture")
}

// MARK: - TARGET DEPENDENCY > Internal
public extension TargetDependency {
    static let yugiTraderAppCore: Self = .project(
        target: "AppCore",
        path: .relativeToRoot("Domains/AppCore")
    )
    
    static let commonUI: Self = .project(
        target: "CommonUI",
        path: .relativeToRoot("Domains/CommonUI")
    )
    
    static let utilities: Self = .project(
        target: "Utilities",
        path: .relativeToRoot("Domains/Utilities")
    )
}

// MARK: - TARGET DEPENDENCY > FEATURES
public extension TargetDependency {
    static let yugiTraderAuth: Self = .project(
        target: "YugiTraderAuth",
        path: .relativeToRoot("Features/Auth")
    )
    
    static let yugiTraderChat: Self = .project(
        target: "YugiTraderChat",
        path: .relativeToRoot("Features/Chat")
    )
}

/**
 SPM 에서 Resolve 할 Package Target을 설정합니다.
 모든 Package는 Dependencies 파일에서 관리하며, 프로젝트는 external로 접근하여 패키지 타겟을 빌드합니다.
 */
public extension Package {
    static let firebase: Self = .remote(
        url: "https://github.com/firebase/firebase-ios-sdk",
        requirement: .upToNextMajor(from: "9.0.0")
    )
    
    static let composableArchitecture: Self = .remote(
        url: "https://github.com/pointfreeco/swift-composable-architecture",
        requirement: .branch("main")
    )
    
    static let sendbirdSDK: Self = .remote(
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
    public static func mainApp(
        name: String,
        targetDependencies: [TargetDependency]
    ) -> Project {
        Project(
            name: name,
            organizationName: "Celan",
            targets: [
                makeAppTarget(
                    name: name,
                    platform: .iOS,
                    dependencies: targetDependencies
                ),
            ]
        )
    }
    
    /**
     해당하는 모든 프레임워크 타겟에 공통으로 CommonModule, Internal 설정 의존성 주입
     */
    public static func featureProject(
        name: String
    ) -> Project {
        Project(
            name: name,
            organizationName: "Celan",
            targets: [
                makeFrameworkTarget(
                    name: name,
                    platform: .iOS,
                    dependencies: [
                        .commonUI,
                        .yugiTraderAppCore,
                        .utilities
                    ]
                )
            ]
        )
    }
    
    /**
     App의 Target을 설정합니다.
     */
    private static func makeAppTarget(
        name: String,
        platform: Platform,
        dependencies: [TargetDependency]
    ) -> Target {
        let infoPlist: [String: InfoPlist.Value] = [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UIMainStoryboardFile": "",
            "UILaunchStoryboardName": "LaunchScreen",
            "FirebaseAppDelegateProxyEnabled": "NO"
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
                base: SettingsDictionary()
                    .automaticCodeSigning(devTeam: "67M6ZS7KS6"),
                configurations: [
                    .debug(name: .debug, settings: .firebase),
                    .release(name: .release, settings: .firebase),
                ],
                defaultSettings: .recommended
            )
        )

        return mainTarget
    }
    
    /**
     Feature Framework의 Target을 설정합니다.
     */
    private static func makeFrameworkTarget(
        name: String,
        platform: Platform,
        dependencies: [TargetDependency]
    ) -> Target {
        let infoPlist: [String: InfoPlist.Value] = [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UIMainStoryboardFile": "",
            "UILaunchStoryboardName": "LaunchScreen",
            "FirebaseAppDelegateProxyEnabled": "NO"
        ]

        let frameworkTarget = Target(
            name: name,
            platform: platform,
            product: .framework,
            bundleId: "com.Celan.\(name)",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
            infoPlist: .extendingDefault(with: infoPlist),
            sources: [.glob(.relativeToManifest("Sources/**"))],
//            resources: [.glob(pattern: .relativeToManifest("Resources/**"))],
//            기능을 구현하는 모듈에 리소스가 필요한가?
            resources: [],
            dependencies: dependencies,
            settings: .settings(
                base: SettingsDictionary().automaticCodeSigning(devTeam: "67M6ZS7KS6"),
                configurations: [
                    .debug(name: .debug, settings: .firebase),
                    .release(name: .release, settings: .firebase),
                ],
                defaultSettings: .recommended
            )
        )
        
        return frameworkTarget
    }
}
