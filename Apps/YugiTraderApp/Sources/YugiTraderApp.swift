import SwiftUI
import FirebaseCore
import YugiTraderLoginKit
import YugiTraderChatUI

@main
struct YugiTraderApp: App {
    // Inject Dependency From Ohter Kits
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MainYTChatRoomView()
            }
        }
    }
}

