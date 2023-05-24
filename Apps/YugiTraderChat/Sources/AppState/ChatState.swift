//
//  AppState.swift
//  YugiTraderChat
//
//  Created by Celan on 2023/05/24.
//  Copyright © 2023 Celan. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

enum StateFilter: String {
    case all, proceeding, completed
}

struct SendbirdChatStore: ReducerProtocol {
    struct State: Equatable {
        var chatStateFilter: StateFilter = .all
    }
    
    enum Action: Equatable {
        case sendChat
        case afterSendChat
    }
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .sendChat:
                state.chatStateFilter = .proceeding
                print("CHAT IS NOW SENDING")
                return .send(.afterSendChat)
                
            case .afterSendChat:
                state.chatStateFilter = .completed
                return .none
            }
        }
    }
}

struct TestView: View {
    let store: StoreOf<SendbirdChatStore>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Button {
                    viewStore.send(.sendChat)
                } label: {
                    Text(viewStore.chatStateFilter == .all ? "\(viewStore.chatStateFilter.rawValue)" : "Done")
                }
            }
        }
    }
}

struct TestPreview: PreviewProvider {
    static var previews: some View {
        TestView(
            store: Store(
                initialState: SendbirdChatStore.State(
                    chatStateFilter: .all
                ),
                reducer: {
            SendbirdChatStore()
        }))
    }
}
