import ProjectDescription

let workspace = Workspace.create()

extension Workspace {
    
    static func create() -> Workspace {
        Workspace(
            name: "TCA_YugiTrader",
            projects: [
                "App/**",
                "Demos/**",
                "Domains/**",
                "Features/**",
            ],
            schemes: []
//            schemes: [appScheme(name: "YugiTraderChat")]
        )
    }
}

// MARK: - Scheme
extension Workspace {
    static func schemes(appNames: [String]) -> [Scheme] {
        appNames.map {
            appScheme(name: $0)
        }
    }
    
    static func appScheme(name: String) -> Scheme {
        Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(
                targets: [.project(path: "App/\(name)", target: name)],
//                targets: [.project(path: "Features/\(name)", target: name)],
                preActions: []
            ),
            runAction: .runAction(
                executable: .project(path: "App/\(name)", target: name)
//                executable: .project(path: "Features/\(name)", target: name)
            )
        )
    }

}
