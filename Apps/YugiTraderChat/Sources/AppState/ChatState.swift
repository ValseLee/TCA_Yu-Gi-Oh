//
//  AppState.swift
//  YugiTraderChat
//
//  Created by Celan on 2023/05/24.
//  Copyright © 2023 Celan. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import YugiTraderChatUI
import YugiTraderChatKit

struct TestView: View {
    let store: StoreOf<ChatStateStore>
    
    var body: some View {
        ScrollView {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                VStack {
                    Button {
                        viewStore.send(.sendChat)
                    } label: {
                        Text(viewStore.chatStateFilter == .all ? "\(viewStore.chatStateFilter.rawValue)" : "Done")
                    }
                }
            }
            
            WithViewStore(self.store, observe: \.name) { name in
                VStack {
                    Text("\(name.state)")
                }
            }
        }
    }
}

struct TestPreview: PreviewProvider {
    static var previews: some View {
        TestView(
            store: Store(
                initialState: ChatStateStore.State(
                    chatStateFilter: .all,
                    name: ""
                ),
                reducer: {
                    ChatStateStore()
        }))
    }
}
