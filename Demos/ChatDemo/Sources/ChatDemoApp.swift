//
//  ChatDemoApp.swift
//  ChatDemo
//
//  Created by Celan on 2023/06/27.
//  Copyright © 2023 Celan. All rights reserved.
//

import SwiftUI
import YugiTraderChat
import ComposableArchitecture

@main
struct ChatDemoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MainYTChatRoomView(
                    store: Store(
                        initialState: ChatStateStore.State(
                            chatStateFilter: .all,
                            currentUserName: "Current",
                            scrollDate: .now,
                            scrollHighlight: "",
                            isCalendarShown: false,
                            messageBubbleAlignment: .leading,
                            messageBubbleHorizontalAlignment: .leading,
                            messageBubbleBackgroundColor: .primary
                        ),
                        reducer: ChatStateStore()
                    ),
                    isCalendarShown: false
                )
            }
        }
    }
}
