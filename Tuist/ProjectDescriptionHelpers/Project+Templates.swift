import ProjectDescription

extension Project {
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
                        .project(
                            target: "CommonModule",
                            path: .relativeToRoot("Modules/CommonModule")
                        )
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
            settings: nil
        )
        
        return mainTarget
    }
}
