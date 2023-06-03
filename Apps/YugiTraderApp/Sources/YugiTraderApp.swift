import SwiftUI
import FirebaseCore
import YugiTraderAppInternal
import YugiTraderLoginKit

@main
struct YugiTraderApp: App {
    // Dependency From YugiTraderAppInternal
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                YTLoginView()
            }
        }
    }
}

