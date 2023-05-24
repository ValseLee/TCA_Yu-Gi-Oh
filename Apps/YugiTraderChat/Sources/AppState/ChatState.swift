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

struct ChatStateStore: ReducerProtocol {
    struct State: Equatable {
        var chatStateFilter: StateFilter = .all
        var name: String
    }
    
    enum Action: Equatable {
        case sendChat
        case afterSendChat
        case changeName
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
                return .send(.changeName)
            
            case .changeName:
                state.name = state.chatStateFilter.rawValue
                return .none
            }
        }
    }
}

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
            
            WithViewStore(self.store, observe: \.name) { viewStore in
                VStack {
                    
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
